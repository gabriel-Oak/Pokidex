import 'package:flutter/material.dart';
import 'package:pokidex/views/pokemons/pokemons_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokídex',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PokemonsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
