import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_card.dart';
import 'package:pokidex/views/pokemons/pokemons_event.dart';
import 'package:pokidex/views/pokemons/pokemons_state.dart';

class PokemonsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonsBloc, PokemonState>(
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
                tooltip: 'Página anterior',
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
                tooltip: 'Próxima página',
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: state.pokemons.length,
                        itemBuilder: (contex, index) => PokemonsCard(
                          pokemon: state.pokemons[index],
                        ),
                      )
                    : Center(
                        child: Text('Nenhum pokemon :('),
                      ),
          ),
        );
      },
    );
  }

  void changePage(BuildContext context, int offSet) {
    context.bloc<PokemonsBloc>().add(GetPokemons(offSet: offSet));
  }
}
