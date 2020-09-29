import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/helpers/models/pokemon_model.dart';
import 'package:pokidex/helpers/pokemons/pokemon_service.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_bloc.dart';
import 'package:pokidex/views/pokemon_details/pokemon_details_content.dart';

class PokemonDetailsPage extends StatelessWidget {
  final PokemonModel pokemon;
  final PokemonService service;
  final int initialColor;
  final int count;

  PokemonDetailsPage({
    @required this.pokemon,
    @required this.service,
    @required this.initialColor,
    @required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonDetailsBloc>(
      create: (context) => PokemonDetailsBloc(
        service: service,
        initialColor: initialColor,
        id: pokemon.apiId,
        pokemon: pokemon,
        count: count,
      ),
      child: Scaffold(body: PokemonDetailsContent()),
    );
  }
}
