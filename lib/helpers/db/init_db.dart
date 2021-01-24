import 'package:flutter/material.dart';
import 'package:pokidex/helpers/db/scripts/favoritesTable.dart';
import 'package:pokidex/helpers/db/scripts/pokemonsTable.dart';
import 'package:sqflite/sqflite.dart';

Future initDb({@required Database db}) async {
  try {
    await db.execute(pokemonsTable);
    await db.execute(favoritesTable);
  } catch (e) {
    print(e);
  }
}
