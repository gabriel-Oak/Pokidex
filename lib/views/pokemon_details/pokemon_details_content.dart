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
                          padding: EdgeInsets.only(top: 16, left: 16),
                          child: Text(
                            pokemon.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
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
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Text('data'),
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
