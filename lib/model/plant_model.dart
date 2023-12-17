/*
  Author: Karolína Pirohová
  Description: Plant class represents information about a plant, including its properties and a factory method for JSON deserialization.
*/

class Plant {
  final int id;
  final String latin;
  final String description;
  final String names;
  final String watering;
  final int wateringPeriod;
  final String difficulty;
  final String light;
  final String tips;
  final String fertilizing;
  final int fertilizingPeriod;
  final String information;
  final String image;

  Plant({
    required this.id,
    required this.latin,
    required this.description,
    required this.names,
    required this.watering,
    required this.wateringPeriod,
    required this.difficulty,
    required this.light,
    required this.tips,
    required this.fertilizing,
    required this.fertilizingPeriod,
    required this.information,
    required this.image,
  });

  factory Plant.fromJson(Map<String, dynamic> json) {
    return Plant(
      id: json['id'],
      latin: json['latin'],
      description: json['description'],
      names: json['names'],
      watering: json['watering'],
      wateringPeriod: json['wateringPeriod'],
      difficulty: json['difficulty'],
      light: json['light'],
      tips: json['tips'],
      fertilizing: json['fertilizing'],
      fertilizingPeriod: json['fertilizingPeriod'],
      information: json['information'],
      image: json['image'],
    );
  }
}
