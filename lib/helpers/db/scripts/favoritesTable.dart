final favoritesColumns = [
  'id',
  'type',
  'itemId',
];

final favoritesTable = '''
  CREATE TABLE favorites (
    id INTEGER PRIMARY KEY,
    type STRING NOT NULL,
    itemId INTEGER NOT NULL
  );
''';
