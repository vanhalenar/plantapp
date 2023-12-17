/*
  Author: Tomáš Mikát
  Description: Controller for page for user's collections
*/

// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantapp/model/usercoll_model.dart';
import 'package:plantapp/model/coll_model.dart';

class UserCollController {
  List<UserColl> _colls = [];

  List<UserColl> get colls => _colls;

  Future<void> loadCollectionsFromAsset() async {
    try {
      final String data =
          await rootBundle.loadString('assets/userCollections.json');
      final List<dynamic> jsonData = json.decode(data);
      _colls = jsonData.map((e) => UserColl.fromJson(e)).toList();
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> _writeToFile(List<UserColl> userColls) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/userCollections.json');
      print('Writing to file: ${file.path}');
      await file.writeAsString(jsonEncode(userColls));
      print('Write successful!');
    } catch (e) {
      print('Error writing to file: $e');
    }
  }

  Future<void> loadCollectionsFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/userCollections.json');
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonData = json.decode(content);
        _colls = jsonData.map((e) => UserColl.fromJson(e)).toList();
        print("collection count on load from file: ${_colls.length}");
      }
    } catch (e) {
      print('Error loading collections from file: $e');
    }
  }

  Future<void> newCollection(String collName) async {
    await loadCollectionsFromFile();
    _colls.add(UserColl(collName: collName, plantIds: [], plantNames: []));
    await _writeToFile(_colls);
  }

  Future<void> updateCollection(String newName, int oldIndex) async {
    if (oldIndex != -1) {
      _colls[oldIndex].collName = newName;
      await _writeToFile(_colls);
      print('Collection found: ${_colls[oldIndex].collName}');
    } else {
      print('Collection not found: ${_colls[oldIndex].collName}');
    }
  }

  Future<void> deleteCollection(int collIndex) async {
    await loadCollectionsFromFile();
    _colls.removeAt(collIndex);
    await _writeToFile(_colls);
  }

  Future<void> addPlantToCollection(int plantIndex, int collIndex) async {
    await loadCollectionsFromFile();
    _colls[collIndex].plantIds.add(_colls[0].plantIds[plantIndex]);
    _colls[collIndex].plantNames.add(_colls[0].plantNames[plantIndex]);
    _colls[0].plantIds.removeAt(plantIndex);
    _colls[0].plantNames.removeAt(plantIndex);
    await _writeToFile(_colls);
  }

  Future<void> addPlantToCollectionByPlant(Collection plant) async {
    await loadCollectionsFromFile();
    _colls[0].plantIds.add(plant.databaseId);
    _colls[0].plantNames.add(plant.nickname);
    await _writeToFile(_colls);
  }

  Future<void> removePlantFromCollection(int plantIndex, int collIndex) async {
    await loadCollectionsFromFile();
    _colls[0].plantIds.add(_colls[collIndex].plantIds[plantIndex]);
    _colls[0].plantNames.add(_colls[collIndex].plantNames[plantIndex]);
    _colls[collIndex].plantIds.removeAt(plantIndex);
    _colls[collIndex].plantNames.removeAt(plantIndex);
    await _writeToFile(_colls);
  }

  void seedFile() async {
    await loadCollectionsFromAsset();
    _writeToFile(_colls);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/userCollections.json');
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
}
