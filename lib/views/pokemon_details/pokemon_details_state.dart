import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/models/pokemon_model.dart';

class PokemonDetailsState extends Equatable {
  final bool loading;
  final PokemonModel pokemon;
  final int initialColor;
  final String errorMessage;
  final int currentId;
  final int count;

  PokemonDetailsState({
    @required this.initialColor,
    @required this.currentId,
    @required this.count,
    this.loading = false,
    this.pokemon,
    this.errorMessage = '',
  });

  PokemonDetailsState evolute({
    bool loading,
    PokemonModel pokemon,
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
      count: count ?? this.count,
    );
  }

  @override
  List<Object> get props =>
      [loading, pokemon, initialColor, errorMessage, currentId, count];
}
