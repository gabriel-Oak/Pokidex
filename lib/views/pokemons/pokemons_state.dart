import 'package:equatable/equatable.dart';
import 'package:pokidex/helpers/pokemon_helper.dart';

class PokemonState extends Equatable {
  final bool loading;
  final List<Pokemon> pokemons;
  final int count;
  final bool hasNext;
  final bool hasPrev;
  final int offSet;

  PokemonState({
    this.loading = false,
    this.count,
    this.hasNext = false,
    this.hasPrev = false,
    this.pokemons,
    this.offSet = 0,
  });

  PokemonState evolute({loading, count, hasNext, hasPrev, pokemons, offSet}) {
    return PokemonState(
      loading: loading ?? this.loading,
      count: count ?? this.count,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
      pokemons: pokemons ?? this.pokemons,
      offSet: offSet ?? this.offSet,
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
      ];
}
