final pokemonsTable = '''
  CREATE TABLE pokemons (
    idApp INTEGER,
    apiId INTEGER UNIQUE,
    name TEXT,
    heigth INTEGER,
    weight INTEGER,
    img TEXT,
    types TEXT,
    abilities TEXT,
    stats TEXT
  );
''';
