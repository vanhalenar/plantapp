import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:plantapp/model/collection_model.dart';

class CollectionController {
  List<Plant> _tasks = [];

  List<Plant> get tasks => _tasks;

  Future<void> loadPlantsFromAsset() async {
    try {
      final String data =
          await rootBundle.loadString('assets/plantCollection.json');
      final List<dynamic> jsonData = json.decode(data);
      _tasks = jsonData.map((e) => Plant.fromJson(e)).toList();
    } catch (e) {
      // Handle errors or exceptions
      // ignore: avoid_print
      print('Error loading data: $e');
    }
  }

  String waterOrFertilize(Plant plant) {
    if (plant.needWater == 1 && plant.needFertilizer == 0) {
      return "water";
    } else if (plant.needFertilizer == 1 && plant.needWater == 0) {
      return "fertilize";
    } else {
      return "problem";
    }
  }
}
