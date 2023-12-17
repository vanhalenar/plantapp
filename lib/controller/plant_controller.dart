/*
  Author: Karolína Pirohová
  Description: This file contains the PlantController class, responsible for managing plant data.
    It includes the loading of plant data from the 'plantDatabase.json' asset.
    The class provides a list of Plant objects through the 'plants' getter.
*/
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:plantapp/model/plant_model.dart';

class PlantController {
  List<Plant> _plants = [];

  List<Plant> get plants => _plants;

  Future<void> loadPlantsFromAsset() async {
    try {
      // Load the JSON data from the asset
      final String data = await rootBundle.loadString('assets/plantDatabase.json');
      
      // Print the loaded JSON data for debugging
      //print('Loaded JSON Data: $data');

      // Parse the JSON data
      final List<dynamic> jsonData = json.decode(data);

      // Convert JSON data to Plant objects
      _plants = jsonData.map((e) => Plant.fromJson(e)).toList();
      
      // Print the number of plants loaded for debugging
      //print('Number of Plants Loaded: ${_plants.length}');
      //print('Loaded Plant IDs: ${_plants.map((plant) => plant.id).join(', ')}');

    } catch (e) {
      // Handle errors or exceptions
      print('Error loading data: $e');
    }
  }
}
