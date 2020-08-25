import 'package:equatable/equatable.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';

class PokemonState extends Equatable {
  final bool loading;
  final List<Pokemon> pokemons;
  final int count;
  final bool hasNext;
  final bool hasPrev;
  final int offSet;
  final String errorMessage;

  PokemonState({
    this.loading = false,
    this.count,
    this.hasNext = false,
    this.hasPrev = false,
    this.pokemons,
    this.offSet = 0,
    this.errorMessage = '',
  });

  PokemonState evolute({
    bool loading,
    int count,
    bool hasNext,
    bool hasPrev,
    List<Pokemon> pokemons,
    int offSet,
    String errorMessage,
  }) {
    return PokemonState(
      loading: loading ?? this.loading,
      count: count ?? this.count,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
      pokemons: pokemons ?? this.pokemons,
      offSet: offSet ?? this.offSet,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        loading,
        pokemons,
        hasNext,
        hasPrev,
        count,
        offSet,
        errorMessage,
      ];
}
