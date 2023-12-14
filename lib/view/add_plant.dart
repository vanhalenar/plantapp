// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:plantapp/controller/plant_controller.dart';
import 'package:plantapp/view/plant_profile.dart';
import 'package:plantapp/model/plant_model.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({Key? key}) : super(key: key);

  @override
  AddPlantState createState() => AddPlantState();
}

class AddPlantState extends State<AddPlant> {
  List<Plant> plants = [];
  bool dataLoaded = false; // Flag to track whether data is loaded

  @override
  void initState() {
    super.initState();
    loadPlants();
  }

  Future<void> loadPlants() async {
    if (!dataLoaded) {
      // Creating a single instance of PlantController
      PlantController plantController = PlantController();
      
      await plantController.loadPlantsFromAsset();
      setState(() {
        // Use the data from the same instance of PlantController!
        plants = plantController.plants; 
        dataLoaded = true;
      });

      // Print the IDs of loaded plants for debugging
      //print('Loaded Plant IDs: ${plants.map((plant) => plant.id).join(', ')}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Checking if the correct amount of data is loaded
    if (dataLoaded) {
      return Scaffold(
        body: ListView.builder(
          itemCount: plants.length,
          itemBuilder: (context, index) {
            final plant = plants[index];
            final uniqueKey = Key('plant_card_${plant.id}');
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PlantProfileCard(plant: plant),
                ));
              },
              child: PlantCard(key: uniqueKey, plant: plant),
            );
          },
        ),
      );
    } else {
      // Loading indicator
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: 300,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(plant.image),
                  radius: 30,
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plant.latin, // Displaying the Latin name of the plant
                    ),
                    Row(
                      children: [
                        Icon(Icons.thermostat),
                        Icon(Icons.water_drop_sharp),
                      ],
                    ),
                  ],
                ),
                Spacer(), // Added a spacer to push the info icon to the right
                Icon(Icons.info_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
