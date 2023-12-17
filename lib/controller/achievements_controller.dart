// ignore_for_file: avoid_print

import 'package:plantapp/model/achievement_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

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
}
