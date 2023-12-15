// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantapp/model/task_model.dart';
import 'package:plantapp/model/plant_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class TaskController {
  List<Task> _tasks = [];

  List<Plant> _plants = [];

  List<Task> get tasks => _tasks;

  List<Plant> get plants => _plants;

  Future<void> loadTasksFromAsset() async {
    try {
      final String data = await rootBundle.loadString('assets/tasks.json');
      final List<dynamic> jsonData = json.decode(data);
      _tasks = jsonData.map((e) => Task.fromJson(e)).toList();
    } catch (e) {
      // Handle errors or exceptions
      print('Error loading data from asset: $e');
    }
  }

  Future<void> loadPlantsFromAsset() async {
    try {
      // Load the JSON data from the asset
      final String data =
          await rootBundle.loadString('assets/plantDatabase.json');

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

  Future<void> loadPlantsFromFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      _tasks = jsonData.map((e) => Task.fromJson(e)).toList();

      await loadPlantsFromAsset();
    } catch (e) {
      print('Error loading data from file: $e');
    }
  }

  String waterOrFertilize(Task plant) {
    if (plant.needWater == 1 && plant.needFertilizer == 0) {
      return "water";
    } else if (plant.needFertilizer == 1 && plant.needWater == 0) {
      return "fertilize";
    } else {
      return "problem";
    }
  }

  Color blueOrBrown(Task plant) {
    if (plant.needWater == 1 && plant.needFertilizer == 0) {
      return const Color(0xFF508991);
    } else if (plant.needFertilizer == 1 && plant.needWater == 0) {
      return const Color(0xFF9D8858);
    } else {
      return Colors.white;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/tasks.json');
  }

  void seedIfNoFileExists() async {
    final file = await _localFile;
    bool fileExists = await file.exists();
    if (fileExists) {
      print('file do be existin doe');
    } else {
      print('file aint there brudda');
      seedFile();
    }
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    String encoded = jsonEncode(_tasks);
    writeTasks(encoded);
  }

  Future<void> writeTasks(String tasks) async {
    final file = await _localFile;

    // Write the file
    file.writeAsString(tasks);
  }

  void seedFile() async {
    await loadTasksFromAsset();
    String encoded = jsonEncode(_tasks);
    writeTasks(encoded);
  }
}
