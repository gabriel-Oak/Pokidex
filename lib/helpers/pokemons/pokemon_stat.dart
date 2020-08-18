class PokemonStat {
  int baseStat;
  int effort;
  String name;

  PokemonStat.fromMap(Map map) {
    baseStat = map['baseStat'];
    effort = map['effort'];
    name = map['name'];
  }

  PokemonStat.fromApi(Map map) {
    baseStat = map['base_stat'];
    effort = map['effort'];
    name = map['stat']['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'baseStat': baseStat,
      'name': name,
      'effort': effort,
    };
  }

  static Map<String, dynamic> mapTransform(Map map) {
    return {
      'baseStat': map['base_stat'],
      'effort': map['effort'],
      'name': map['stat']['name'],
    };
  }
}
