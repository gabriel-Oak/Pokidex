import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_bloc.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_state.dart';

class PokemonDetailsContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
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
                          padding:
                              EdgeInsets.only(top: 16, left: 16, right: 16),
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
                          child: Container(
                            padding: EdgeInsets.only(top: 84),
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.topCenter,
                              fit: StackFit.expand,
                              children: <Widget>[
                                Positioned(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                    child: Container(
                                      color: Colors.white,
                                      child: SingleChildScrollView(
                                          padding: EdgeInsets.only(
                                            top: 40,
                                            left: 16,
                                            right: 16,
                                            bottom: 16,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                              Text('data'),
                                            ],
                                          )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -130,
                                  height: 200,
                                  child: FadeInImage.assetNetwork(
                                    image: pokemon.img,
                                    placeholder: 'assets/pokiball.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
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
    );
  }

  Color getColor(Pokemon pokemon, int initialColor) {
    return pokemon != null ? Color(pokemon.cardColor) : Color(initialColor);
  }
}
