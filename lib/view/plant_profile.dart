// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PlantProfileCard extends StatelessWidget {
  const PlantProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant'),
      ),     
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/images/monstera.jpg'),
          radius: 50,
        ),
      ),
    );
  }
}
