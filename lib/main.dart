import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemon_service.dart';
import 'package:pokidex/views/pokemons/pokemons_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PokemonService pokeService = PokemonService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokídex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PokemonsPage(service: pokeService),
    );
  }
}
