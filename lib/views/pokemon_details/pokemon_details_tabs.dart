import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/helpers/pokemons/pokemon_stat.dart';

class PokemonDetailsTabs extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailsTabs({@required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: TabBar(
          tabs: <Widget>[
            Tab(
              child: Text('Stats', style: TextStyle(color: Colors.black)),
            ),
            Tab(
              child: Text('Info', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: pokemon.stats
                    .map(
                      (e) => Padding(
                        padding: EdgeInsets.only(bottom: 18),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Container(
                                width: 98,
                                child: Text(e.name),
                              ),
                            ),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: e.baseStat / 100,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Container(
                                alignment: Alignment.centerRight,
                                width: 24,
                                child: Text(e.baseStat.toString()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),

                // children: <Widget>[
                //   Row(
                //     children: pokemon.stats.map((PokemonStat e) => null)
                //  <Widget>[
                // ],
                //   ),
                // ],
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('data'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
