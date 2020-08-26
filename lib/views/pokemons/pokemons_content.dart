import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/helpers/pokemons/pokemon_service.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_page.dart';
import 'package:pokidex/views/pokemons/pokemons_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_card.dart';
import 'package:pokidex/views/pokemons/pokemons_event.dart';
import 'package:pokidex/views/pokemons/pokemons_state.dart';

class PokemonsContent extends StatelessWidget {
  final PokemonService service;

  PokemonsContent({@required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonsBloc, PokemonState>(
      listener: (ctx, state) {
        if (state.errorMessage.isNotEmpty) {
          final snackbar = SnackBar(
            duration: Duration(minutes: 1),
            content: Text(state.errorMessage),
            action: SnackBarAction(
                label: 'Recarregar',
                onPressed: () {
                  ctx
                      .bloc<PokemonsBloc>()
                      .add(GetPokemons(offSet: state.offSet));
                }),
          );
          Scaffold.of(ctx).showSnackBar(snackbar);
        }
      },
      listenWhen: (previous, current) =>
          current.errorMessage.isNotEmpty &&
          current.errorMessage != previous.errorMessage,
      child: BlocBuilder<PokemonsBloc, PokemonState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Pokídex',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                ],
              ),
              actions: <Widget>[
                IconButton(
                  tooltip: 'Previous page',
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (!state.loading && state.hasPrev)
                      changePage(context, state.offSet - 20);
                  },
                ),
                IconButton(
                  tooltip: 'Next page',
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (!state.loading && state.hasNext)
                      changePage(context, state.offSet + 20);
                  },
                ),
              ],
            ),
            body: Container(
              child: state.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.pokemons.length > 0
                      ? GridView.builder(
                          padding: EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1.3,
                          ),
                          itemCount: state.pokemons.length,
                          itemBuilder: (contex, index) => PokemonsCard(
                            pokemon: state.pokemons[index],
                            onTap: (int id) => viewDetails(
                              contex,
                              state.pokemons[index],
                              state.pokemons[index].cardColor,
                              state.count,
                            ),
                          ),
                        )
                      : Center(
                          child: Text('Havan\'t found pokémons yet :('),
                        ),
            ),
          );
        },
      ),
    );
  }

  void changePage(BuildContext context, int offSet) {
    context.bloc<PokemonsBloc>().add(GetPokemons(offSet: offSet));
  }

  void viewDetails(
      BuildContext context, Pokemon pokemon, int initialColor, int count) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, _animation, _) => PokemonDetailsPage(
          pokemon: pokemon,
          service: service,
          initialColor: initialColor,
          count: count,
        ),
        transitionDuration: Duration(milliseconds: 640),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }
}
