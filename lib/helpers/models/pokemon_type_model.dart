import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PokemonTypeModel extends Equatable {
  final int slot;
  final String name;
  final String colorString;

  PokemonTypeModel({
    @required this.slot,
    @required this.name,
    @required this.colorString,
  });

  factory PokemonTypeModel.fromMap(Map map) {
    return PokemonTypeModel(
      slot: map['slot'],
      name: map['name'],
      colorString: map['colorString'],
    );
  }

  factory PokemonTypeModel.fromApi(Map map) {
    return PokemonTypeModel(
      slot: map['slot'],
      name: map['name'],
      colorString: map['colorString'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'slot': slot,
      'name': name,
      'colorString': colorString,
    };
  }

  static Map<String, dynamic> mapTransform(Map map) {
    return {
      'slot': map['slot'],
      'name': map['type']['name'],
    };
  }

  int get color => int.parse(colorString.replaceAll(RegExp(r'#'), '0xFF'));

  List<Object> get props => [slot, name, colorString];
}
