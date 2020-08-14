import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/helpers/pokemons/pokemon_service.dart';
import 'package:pokidex/views/pokemons/pokemons_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static PokemonHelper pokemonHelper = PokemonHelper();
  final PokemonService pokeService = PokemonService(
    pokemonHelper: pokemonHelper,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokídex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PokemonsPage(service: pokeService),
      debugShowCheckedModeBanner: false,
    );
  }
}
