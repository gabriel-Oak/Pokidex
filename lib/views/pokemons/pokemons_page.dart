import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/helpers/pokemon_service.dart';
import 'package:pokidex/views/pokemons/pokemons_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_content.dart';
import 'package:pokidex/views/pokemons/pokemons_event.dart';

class PokemonsPage extends StatelessWidget {
  final PokemonService service;

  PokemonsPage({@required this.service});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonsBloc>(
      create: (context) => PokemonsBloc(service: service)..add(GetPokemons()),
      child: PokemonsContent(),
    );
  }
}
