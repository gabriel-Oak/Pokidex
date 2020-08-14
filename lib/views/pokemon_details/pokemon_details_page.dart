import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/helpers/pokemons/pokemon_service.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_bloc.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_content.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_event.dart';

class PokemonDetailsPage extends StatelessWidget {
  final int id;
  final PokemonService service;
  final int initialColor;

  PokemonDetailsPage({
    @required this.id,
    @required this.service,
    @required this.initialColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailsBloc>(
      create: (context) =>
          PokemonDetailsBloc(service: service, initialColor: initialColor)
            ..add(GetPokemonData(id: id)),
      child: PokemonDetailsContent(),
    );
  }
}
