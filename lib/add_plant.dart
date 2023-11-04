// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plantapp/controller/plant_controller.dart';

class AddPlant extends StatelessWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PlantController().loadPlantsFromAsset(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PlantCard(); // Data is loaded; display the PlantCard
          } else {
            return Center(child: CircularProgressIndicator()); // Show a loading indicator during data loading
          }
        },
      ),
    );
  }
}


class PlantCard extends StatelessWidget {
  const PlantCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final plantController = PlantController();
    //final plants = plantController.plants;
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 300,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/monstera.jpg'),
                  radius: 30,
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monstera deliciosa', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.thermostat),
                        Icon(Icons.water_drop_sharp),
                      ],
                    )
                  ],
                ),
                SizedBox(width: 65),
                Icon(Icons.info_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
