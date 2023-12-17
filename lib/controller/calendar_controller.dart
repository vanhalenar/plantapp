import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:plantapp/model/task_model.dart';

/// Example event class.
class Event {
  final String title;
  final DateTime date;

  const Event(this.title, this.date);

  @override
  String toString() => title;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

Future<List<Event>> loadTasksFromJson() async {
  try {
    String jsonString = await rootBundle.loadString('assets/tasks.json');
    final List<dynamic> parsedJson = json.decode(jsonString);

    final List<Task> plants =
        parsedJson.map((eventJson) => Task.fromJson(eventJson)).toList();

    List<Event> tasks = [];

    for (final plant in plants) {
      if (plant.needWater == 1) {
        tasks.add(Event("${plant.nickname} | Needs Watering", plant.date));
      } else {
        tasks.add(Event("${plant.nickname} | Needs Fertilizing", plant.date));
      }
    }

    return tasks;
  } catch (e) {
    // ignore: avoid_print
    print('Error loading tasks from JSON: $e');
    return [];
  }
}

Future<List<Event>> loadTasksFromFile() async {
  try {
    final file = await _localFile;
    String jsonString = await file.readAsString();
    final List<dynamic> parsedJson = json.decode(jsonString);

    final List<Task> plants =
        parsedJson.map((eventJson) => Task.fromJson(eventJson)).toList();

    List<Event> tasks = [];

    for (final plant in plants) {
      if (plant.needWater == 1) {
        tasks.add(Event("${plant.nickname} | Needs Watering", plant.date));
      } else {
        tasks.add(Event("${plant.nickname} | Needs Fertilizing", plant.date));
      }
    }

    return tasks;
  } catch (e) {
    // ignore: avoid_print
    print('Error loading tasks from JSON: $e');
    return [];
  }
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/tasks.json');
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
