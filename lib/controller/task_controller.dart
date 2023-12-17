/*
  Author: Timotej Halenár
  Description: Used to retrieve, modify and store task data,
  provides converter functions
*/
// ignore_for_file: avoid_print, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantapp/model/coll_model.dart';
import 'package:plantapp/model/task_model.dart';
import 'package:plantapp/model/plant_model.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'plant_controller.dart';
import 'coll_controller.dart';
import 'achievements_controller.dart';

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

      filterTodayTasks();
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

  Future<void> loadTasksFromFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      _tasks = jsonData.map((e) => Task.fromJson(e)).toList();

      filterTodayTasks();

      await loadPlantsFromAsset();
    } catch (e) {
      print('Error loading data from file: $e');
    }
  }

  void filterTodayTasks() {
    List<Task> temp = [];
    for (final task in _tasks) {
      if (DateUtils.isSameDay(task.date, DateTime.now())) {
        temp.add(task);
      }
    }
    _tasks = temp;
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

    AchievementsController achievementsController = AchievementsController();
    achievementsController.incrementAchievement(task);
    _scheduleNewTask(task);
  }

  void _scheduleNewTask(Task task) async {
    PlantController plantController = PlantController();
    await plantController.loadPlantsFromAsset();

    int waterInterval =
        plantController.plants[task.databaseId - 1].wateringPeriod;

    int fertilizeInterval =
        plantController.plants[task.databaseId - 1].fertilizingPeriod;

    DateTime newDate;

    if (task.needFertilizer == 1) {
      newDate = task.date.add(Duration(days: waterInterval));
    } else if (task.needWater == 1) {
      newDate = task.date.add(Duration(days: fertilizeInterval));
    } else
      print("adding default duration, something went wrong");

    newDate = DateTime.now().add(const Duration(days: 7));

    Task newTask = Task(
        databaseId: task.databaseId,
        nickname: task.nickname,
        needWater: task.needWater,
        needFertilizer: task.needFertilizer,
        date: newDate);

    _tasks.add(newTask);

    String encoded = jsonEncode(_tasks);

    await writeTasks(encoded);

    CollController collController = CollController();

    await collController.loadPlantsFromFile();

    List<Collection> collection = collController.collection;
    Collection? temp;
    for (final log in collection) {
      if ((log.databaseId == task.databaseId) &&
          log.nickname == task.nickname) {
        temp = log;
        collection.remove(log);
        break;
      }
    }

    if (temp == null) {
      print("wrong, plant not found in collection i think");
    } else {
      if (task.needWater == 1) {
        temp.lastWatered = DateTime.now();
      } else if (task.needFertilizer == 1) {
        temp.lastFertilized = DateTime.now();
      } else {
        print("invalid task!");
      }

      await collController.updatePlant(temp);
    }
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
