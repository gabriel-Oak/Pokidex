import 'package:flutter/material.dart';
import 'package:pokidex/helpers/utils/poke_colors.dart';

class PokemonType {
  int slot;
  String name;
  int _color;

  PokemonType({
    @required this.slot,
    @required this.name,
    @required int color,
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
    _color = int.parse(typeColor[name].replaceAll(RegExp(r'#'), '0xFF'));
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

  int get color => _color;
}
