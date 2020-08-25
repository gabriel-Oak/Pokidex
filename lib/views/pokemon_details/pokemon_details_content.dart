import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_bloc.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_event.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_state.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_tabs.dart';

class PokemonDetailsContent extends StatelessWidget {
  final int count;
  PokemonDetailsContent({@required this.count});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PokemonDetailsBloc, PokemonDetailsState>(
      listener: (ctx, state) {
        if (state.errorMessage.isNotEmpty) {
          final snackbar = SnackBar(
            duration: Duration(minutes: 1),
            content: Text(state.errorMessage),
            action: SnackBarAction(
                label: 'Recarregar',
                onPressed: () {
                  ctx
                      .bloc<PokemonDetailsBloc>()
                      .add(GetPokemonData(id: state.currentId));
                }),
          );
          Scaffold.of(ctx).showSnackBar(snackbar);
        }
      },
      listenWhen: (previus, state) =>
          state.errorMessage.isNotEmpty &&
          state.errorMessage != previus.errorMessage,
      child: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
        builder: (context, state) {
          final Pokemon pokemon = state.pokemon;
          final int initialColor = state.initialColor;

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: getColor(pokemon, initialColor),
            ),
            body: state.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : pokemon != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 16,
                              left: 16,
                              right: 16,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  pokemon.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '#${pokemon.apiId.toString().padLeft(4, '0')}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16),
                            child: Row(
                              children: pokemon.types
                                  .map((e) => Padding(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Chip(
                                          label: Text(
                                            e.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          backgroundColor: Color(e.color),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.topCenter,
                              fit: StackFit.expand,
                              children: <Widget>[
                                Positioned(
                                  top: -80,
                                  child: Image.asset(
                                    'assets/back.png',
                                    height: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 84),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      child: PokemonDetailsTabs(
                                        pokemon: pokemon,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -36,
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 30),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            if (pokemon.apiId > 1 &&
                                                !state.loading) {
                                              context
                                                  .bloc<PokemonDetailsBloc>()
                                                  .add(GetPokemonData(
                                                    id: pokemon.apiId - 1,
                                                  ));
                                            }
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 180,
                                        child: Hero(
                                          tag: 'image-${state.currentId}',
                                          child: FadeInImage.assetNetwork(
                                            image: pokemon.img,
                                            placeholder: 'assets/pokiball.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            if (pokemon.apiId < count &&
                                                !state.loading) {
                                              context
                                                  .bloc<PokemonDetailsBloc>()
                                                  .add(GetPokemonData(
                                                    id: pokemon.apiId + 1,
                                                  ));
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text('Erro ao carregar pokemon!'),
                      ),
            backgroundColor: getColor(pokemon, initialColor),
          );
        },
      ),
    );
  }

  Color getColor(Pokemon pokemon, int initialColor) {
    return pokemon != null ? Color(pokemon.cardColor) : Color(initialColor);
  }
}
