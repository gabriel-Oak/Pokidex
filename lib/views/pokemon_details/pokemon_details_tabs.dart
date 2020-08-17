import 'package:flutter/material.dart';

class PokemonDetailsTabs extends StatelessWidget {
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
              child: Text('Abilities', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('Status'),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text('abilities'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
