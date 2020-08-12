import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemon_service.dart';
import 'package:pokidex/views/pokemons/pokemons_event.dart';
import 'package:pokidex/views/pokemons/pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonState> {
  final PokemonService service;

  PokemonsBloc({@required this.service})
      : super(PokemonState(pokemons: List()));

  @override
  Stream<PokemonState> mapEventToState(PokemonsEvent event) async* {
    if (event is GetPokemons) {
      yield state.evolute(loading: true, offSet: event.offSet);
      final Map pagination = await service.getPokemons(offSet: event.offSet);
      yield state.evolute(
        loading: false,
        count: pagination['count'],
        hasNext: pagination['hasNext'],
        hasPrev: pagination['hasPrev'],
        pokemons: pagination['pokemons'],
      );
    }
  }
}
