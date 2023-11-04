class Plant {
  final int id;
  final String latin;
  final String description;
  final String names;
  final String watering;
  final String difficulty;
  final String light;
  final String tips;
  final String fertilizing;
  final String information;

  Plant({
    required this.id,
    required this.latin,
    required this.description,
    required this.names,
    required this.watering,
    required this.difficulty,
    required this.light,
    required this.tips,
    required this.fertilizing,
    required this.information,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      latin: json['latin'],
      description: json['description'],
      names: json['names'],
      watering: json['watering'],
      difficulty: json['difficulty'],
      light: json['light'],
      tips: json['tips'],
      fertilizing: json['fertilizing'],
      information: json['information'],
    );
  }
}
