import 'package:flutter/material.dart';
import 'package:pokidex/helpers/pokemons/pokemon_helper.dart';
import 'package:pokidex/helpers/pokemons/pokemon_stat.dart';

class PokemonDetailsTabs extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetailsTabs({@required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TabBar(
            labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            labelColor: Colors.black,
            tabs: <Widget>[
              Tab(child: Text('Stats')),
              Tab(child: Text('Info')),
            ],
          ),
          body: TabBarView(
            children: <Widget>[
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: pokemon.stats
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(right: 16),
                                    child: Container(
                                      child: Text(
                                        e.name.replaceAll('-', ' '),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16),
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        e.baseStat.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: e.baseStat > 100
                                              ? Color(pokemon.cardColor)
                                              : null,
                                          fontWeight: e.baseStat > 100
                                              ? FontWeight.w900
                                              : null,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              LinearProgressIndicator(
                                value: e.baseStat / 100,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(pokemon.cardColor),
                                ),
                                backgroundColor: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Heigth:', style: TextStyle(fontSize: 20)),
                        Text(
                          pokemon.heigth != null
                              ? pokemon.heigth.toString()
                              : '???',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Weight:', style: TextStyle(fontSize: 20)),
                          Text(
                            pokemon.weight != null
                                ? pokemon.weight.toString()
                                : '???',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'Abilities',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: pokemon.abilities
                          .map(
                            (e) => Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Text(
                                e.replaceAll('-', ' '),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              margin: EdgeInsets.only(top: 16),
                            ),
                          )
                          .toList(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
