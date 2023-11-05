// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plantapp/model/plant_model.dart';

class PlantProfileCard extends StatelessWidget {
  final Plant plant;

  const PlantProfileCard({required this.plant, Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Adjust the padding as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start, // Align the entire column content to the left
            children: [
              Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/monstera.jpg'),
                    radius: 50,
                  ),
                  SizedBox(height: 24),
                  Text(
                    plant.latin,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),             
              Text(
                'Description',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 5),
              Text(
                plant.description,
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.left, // Align text to the left
              )
            ],
          ),
        ),
      ),
    );
  }
}
