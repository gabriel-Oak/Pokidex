import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';

class PokemonDetailsState extends Equatable {
  final bool loading;
  final Pokemon pokemon;
  final int initialColor;

  PokemonDetailsState({
    @required this.initialColor,
    this.loading = false,
    this.pokemon,
  });

  PokemonDetailsState evolute({
    bool loading,
    Pokemon pokemon,
    int initialColor,
  }) {
    return PokemonDetailsState(
      loading: loading ?? this.loading,
      pokemon: pokemon ?? this.pokemon,
      initialColor: initialColor ?? this.initialColor,
    );
  }

  @override
  List<Object> get props => [loading, pokemon, initialColor];
}
