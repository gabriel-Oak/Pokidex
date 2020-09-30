final pokemonsColumns = [
  'idApp',
  'apiId',
  'name',
  'heigth',
  'weight',
  'img',
  'types',
  'abilities',
  'stats',
];

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
