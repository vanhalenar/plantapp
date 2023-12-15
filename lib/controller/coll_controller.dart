// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantapp/model/coll_model.dart';

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
    _collection.add(newPlant);
    await _writeToFile(_collection);
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
      }
    } catch (e) {
      // Handle errors or exceptions
      print('Error loading plants from file: $e');
    }
  }
}
