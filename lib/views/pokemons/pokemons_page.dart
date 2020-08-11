import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemon_service.dart';

class PokemonsPage extends StatelessWidget {
  final PokemonService service;

  PokemonsPage({@required this.service});

  @override
  Widget build(BuildContext context) {
    service.getPokemons();
    return Container();
  }
}
