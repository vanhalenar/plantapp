/*
  Author: Karolína Pirohová
  Description: This file contains the CollController class, responsible for managing collections of plants.
    It includes methods for loading plant data from an asset, saving new plants, updating existing plants,
    retrieving a specific plant, deleting a plant, and performing calculations related to plant actions.
    The class uses the PlantController and TaskController classes for additional functionality.
*/

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantapp/model/coll_model.dart';
import 'package:plantapp/model/task_model.dart';
import 'task_controller.dart';
import 'plant_controller.dart';
import 'usercoll_controller.dart';

class CollController {
  List<Collection> _collection = [];

  List<Collection> get collection => _collection;

  Future<void> loadPlantsFromAsset() async {
    try {
      final String data = await rootBundle.loadString('assets/plantColl.json');
      final List<dynamic> jsonData = json.decode(data);
      _collection = jsonData.map((e) => Collection.fromJson(e)).toList();
    } catch (e) {
      // Handle errors or exceptions
      print('Error loading data: $e');
    }
  }

  Future<void> savePlant(Collection newPlant) async {
    await loadPlantsFromFile();
    _collection.add(newPlant);
    print("databaseId: ${newPlant.databaseId}");

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String imageDirectory = "${appDocumentsDirectory.path}/images";

    // Create the directory if it doesn't exist
    await Directory(imageDirectory).create(recursive: true);

    String imagePath = "$imageDirectory/${newPlant.databaseId}.jpg";

    // Save the image file
    if (newPlant.imageFile != null) {
      // Save the image file to the specified path
      await newPlant.imageFile!.copy(imagePath);
      newPlant.photo = imagePath;
    }

    await _writeToFile(_collection);

    TaskController taskController = TaskController();
    await taskController.loadTasksFromFile();

    PlantController plantController = PlantController();
    await plantController.loadPlantsFromAsset();
    int waterInterval =
        plantController.plants[newPlant.databaseId - 1].wateringPeriod;
    int fertilizeInterval =
        plantController.plants[newPlant.databaseId - 1].fertilizingPeriod;

    DateTime waterDate =
        newPlant.lastWatered.add(Duration(days: waterInterval));
    DateTime fertilizeDate =
        newPlant.lastFertilized.add(Duration(days: fertilizeInterval));

    Task waterTask = Task(
        databaseId: newPlant.databaseId,
        nickname: newPlant.nickname,
        needWater: 1,
        needFertilizer: 0,
        date: waterDate);

    Task fertilizeTask = Task(
        databaseId: newPlant.databaseId,
        nickname: newPlant.nickname,
        needWater: 0,
        needFertilizer: 1,
        date: fertilizeDate);

    taskController.tasks.add(waterTask);
    taskController.tasks.add(fertilizeTask);
    String encoded = jsonEncode(taskController.tasks);
    taskController.writeTasks(encoded);

    UserCollController userCollController = UserCollController();
    await userCollController.loadCollectionsFromFile();

    userCollController.addPlantToCollectionByPlant(newPlant);
  }

  Future<void> _writeToFile(List<Collection> plants) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/plantColl.json');
      print('Writing to file: ${file.path}');
      await file.writeAsString(jsonEncode(plants));
      print('Write successful!');
    } catch (e) {
      // Handle errors or exceptions
      print('Error writing to file: $e');
    }
  }

  Future<void> loadPlantsFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/plantColl.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonData = json.decode(content);
        _collection = jsonData.map((e) => Collection.fromJson(e)).toList();
        print("collection size on load from file: ${_collection.length}");
      }
    } catch (e) {
      // Handle errors or exceptions
      print('Error loading plants from file: $e');
    }
  }

  Future<void> updatePlant(Collection updatedPlant) async {
    await loadPlantsFromFile();
    final index = _collection
        .indexWhere((plant) => plant.databaseId == updatedPlant.databaseId);

    if (index != -1) {
      _collection[index] = updatedPlant;
      await _writeToFile(_collection);
    } else {
      // Handle the case where the plant to update is not found
      print('Plant not found for update: ${updatedPlant.databaseId}');
    }
  }

  Future<Collection> getPlant(int databaseId) async {
    await loadPlantsFromFile();
    return _collection.firstWhere((plant) => plant.databaseId == databaseId);
  }

  Future<void> deletePlant(Collection plantToDelete) async {
    await loadPlantsFromFile();
    _collection
        .removeWhere((plant) => plant.databaseId == plantToDelete.databaseId);
    await _writeToFile(_collection);
  }

  void seedFile() async {
    await loadPlantsFromAsset();
    _writeToFile(_collection);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/plantColl.json');
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

  int calculateDaysUntilNextAction(DateTime lastDate, int period) {
    // Calculate the next watering date
    DateTime nextDate = lastDate.add(Duration(days: period));
    nextDate = DateTime(nextDate.year, nextDate.month, nextDate.day);

    DateTime currentDate = DateTime.now();
    currentDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    int daysUntil = nextDate.difference(currentDate).inDays;

    // If the result is negative, set it to 0 (meaning the plant should have already been watered)
    daysUntil = daysUntil < 0 ? 0 : daysUntil;

    return daysUntil;
  }
}
