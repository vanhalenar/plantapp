// ignore_for_file: avoid_print

import 'dart:io';
import 'package:plantapp/model/achievement_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantapp/model/task_model.dart';

class AchievementsController {
  List<Achievement> _achievements = [];

  List<Achievement> _completedAchievements = [];

  List<Achievement> _incompleteAchievements = [];

  List<Achievement> get achievements => _achievements;

  List<Achievement> get completedAchievements => _completedAchievements;

  List<Achievement> get incompleteAchievements => _incompleteAchievements;

  Future<void> loadAchievementsFromAsset() async {
    try {
      final String data =
          await rootBundle.loadString('assets/achievements.json');
      final List<dynamic> jsonData = json.decode(data);
      _achievements = jsonData.map((e) => Achievement.fromJson(e)).toList();

      _completedAchievements = [];
      _incompleteAchievements = [];
      for (final ach in _achievements) {
        if (ach.max > ach.current) {
          _incompleteAchievements.add(ach);
        } else {
          _completedAchievements.add(ach);
        }
      }
    } catch (e) {
      // Handle errors or exceptions
      print('Error loading data from asset: $e');
    }
  }

  Future<void> loadAchievementsFromFile() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final List<dynamic> jsonData = json.decode(contents);
      _achievements = jsonData.map((e) => Achievement.fromJson(e)).toList();
      print("achievements length: ${_achievements.length}");

      _completedAchievements = [];
      _incompleteAchievements = [];
      for (final ach in _achievements) {
        if (ach.max > ach.current) {
          _incompleteAchievements.add(ach);
        } else {
          _completedAchievements.add(ach);
        }
      }
    } catch (e) {
      print('Error loading data from file: $e');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/achievements.json');
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

  void seedFile() async {
    await loadAchievementsFromAsset();
    String encoded = jsonEncode(_achievements);
    writeAchievements(encoded);
  }

  Future<void> writeAchievements(String achievements) async {
    final file = await _localFile;

    // Write the file
    file.writeAsString(achievements);
  }

  void incrementAchievement(Task task) async {
    await loadAchievementsFromFile();

    for (var ach in _achievements) {
      if ((ach.nickname == task.nickname) && (ach.max > ach.current)) {
        if ((ach.type == 0) && (task.needWater == 1)) {
          ach.current++;
          break;
        } else if ((ach.type == 1) && (task.needFertilizer == 1)) {
          ach.current++;
          break;
        }
      }
    }

    String encoded = jsonEncode(_achievements);
    await writeAchievements(encoded);
  }
}
