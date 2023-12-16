import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:plantapp/model/usercoll_model.dart';

class CollController {
  List<UserColl> _colls = [];

  List<UserColl> get colls => _colls;

  Future<void> loadUserCollectionsFromAsset() async {
    try {
      final String data = await rootBundle.loadString('assets/userCollections.json');
      final List<dynamic> jsonData = json.decode(data);
      _colls = jsonData.map((e) => UserColl.fromJson(e)).toList();
    } catch (e) {
      // Handle errors or exceptions
      // ignore: avoid_print
      print('Error loading data: $e');
    }
  }

}