import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:plantapp/model/plant_model.dart';

class PlantController {
  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  Future<void> loadPlantsFromAsset() async {
    try {
      final String data = await rootBundle.loadString('assets/plantDatabase.json');
      final List<dynamic> jsonData = json.decode(data);

      _plants = jsonData.map((e) => Plant.fromJson(e)).toList();
    } catch (e) {
      // Handle errors or exceptions
      // ignore: avoid_print
      print('Error loading data: $e');
    }
  }
}

