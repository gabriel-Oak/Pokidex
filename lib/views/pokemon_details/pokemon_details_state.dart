import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';

class PokemonDetailsState extends Equatable {
  final bool loading;
  final Pokemon pokemon;
  final int initialColor;
  final String errorMessage;
  final int currentId;

  PokemonDetailsState({
    @required this.initialColor,
    @required this.currentId,
    this.loading = false,
    this.pokemon,
    this.errorMessage = '',
  });

  PokemonDetailsState evolute({
    bool loading,
    Pokemon pokemon,
    int initialColor,
    String errorMessage,
    int currentId,
  }) {
    return PokemonDetailsState(
      loading: loading ?? this.loading,
      pokemon: pokemon ?? this.pokemon,
      initialColor: initialColor ?? this.initialColor,
      errorMessage: errorMessage ?? this.errorMessage,
      currentId: currentId ?? this.currentId,
    );
  }

  @override
  List<Object> get props =>
      [loading, pokemon, initialColor, errorMessage, currentId];
}
