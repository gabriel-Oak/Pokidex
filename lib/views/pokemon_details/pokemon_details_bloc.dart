import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/helpers/pokemons/pokemon_service.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_event.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final PokemonService service;

  PokemonDetailsBloc({
    @required this.service,
    @required int initialColor,
    @required int id,
  }) : super(PokemonDetailsState(initialColor: initialColor, currentId: id));

  @override
  Stream<PokemonDetailsState> mapEventToState(
      PokemonDetailsEvent event) async* {
    if (event is GetPokemonData) {
      try {
        yield state.evolute(
          loading: true,
          currentId: event.id,
          errorMessage: '',
        );
        final Pokemon pokemon = await service.getDetails(id: event.id);
        yield state.evolute(loading: false, pokemon: pokemon);
      } catch (e) {
        yield state.evolute(loading: false, errorMessage: e);
      }
    }
  }
}
