import 'package:flutter/material.dart';
import 'package:pokidex/helpers/poke_colors.dart';

class PokemonType {
  int slot;
  String name;
  String _color;

  PokemonType({
    @required this.slot,
    @required this.name,
    @required String color,
  }) {
    _color = color;
  }

  PokemonType.fromMap(Map map) {
    slot = map['slot'];
    name = map['name'];
    _color = map['color'];
  }

  PokemonType.fromApi(Map map) {
    slot = map['slot'];
    name = map['type']['name'];
    _color = typeColor[name];
  }

  Map<String, dynamic> toMap() {
    return {
      'slot': slot,
      'name': name,
      'color': color,
    };
  }

  static Map<String, dynamic> mapTransform(Map map) {
    return {
      'slot': map['slot'],
      'name': map['type']['name'],
    };
  }

  get color => _color;
}
