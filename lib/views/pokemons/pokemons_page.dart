import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokidex/helpers/db/db.dart';
import 'package:pokidex/helpers/repositories/pokemon_repository.dart';
import 'package:pokidex/helpers/services/pokemon_service.dart';
import 'package:pokidex/views/pokemons/pokemons_bloc.dart';
import 'package:pokidex/views/pokemons/pokemons_content.dart';
import 'package:pokidex/views/pokemons/pokemons_event.dart';

class PokemonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PokemonsBloc>(
      create: (context) => PokemonsBloc(
        service: PokemonService(pokemonHelper: PokemonRepository(db: Db())),
      )..add(GetPokemons()),
      child: Scaffold(body: PokemonsContent()),
    );
  }
}
