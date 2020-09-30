import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:pokidex/helpers/models/pokemon_model.dart';
import 'package:pokidex/helpers/services/pokemon_service.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_event.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final PokemonService service;

  PokemonDetailsBloc({
    @required this.service,
    @required int initialColor,
    @required int id,
    @required int count,
    @required PokemonModel pokemon,
  }) : super(PokemonDetailsState(
          initialColor: initialColor,
          currentId: id,
          pokemon: pokemon,
          count: count,
        ));

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
        final PokemonModel pokemon = await service.getDetails(id: event.id);
        yield state.evolute(loading: false, pokemon: pokemon);
      } catch (e) {
        yield state.evolute(loading: false, errorMessage: e);
      }
    }
  }
}
