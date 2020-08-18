import 'package:flutter/foundation.dart';

abstract class PokemonDetailsEvent {}

class GetPokemonData extends PokemonDetailsEvent {
  final int id;

  GetPokemonData({@required this.id});
}
