// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:plantapp/controller/plant_controller.dart';
import 'package:plantapp/view/plant_profile.dart';
import 'package:plantapp/model/plant_model.dart';
import 'package:plantapp/controller/coll_controller.dart';

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
        // Use the data from the same instance of PlantController
        plants = plantController.plants; 
        dataLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final CollController collController = CollController();

    // Checking if the correct amount of data is loaded
    if (dataLoaded) {
      return Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Add padding to the top
          child: AppBar(
            title: Text(
              'Plant Finder',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            backgroundColor: Color(0xFFBFD7B5),
            titleSpacing: 10,
            centerTitle: true,
           ),
         ),
        ),
        body: Column(
        children: [
          SearchBar(), 
          Expanded(
            child: ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                final uniqueKey = Key('plant_card_${plant.id}');
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlantProfileCard(plant: plant, collController: collController),
                    ));
                  },
                  child: PlantCard(key: uniqueKey, plant: plant),
                );
              },
            ),
          ),
        ],
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
class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 30, top: 30, right: 30, bottom: 20),      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for plant',
          prefixIcon: Icon(Icons.search),
          suffixIcon: Padding(
            padding: EdgeInsets.all(8), 
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8), 
                Icon(Icons.filter_alt),
              ],
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }
}
class PlantCard extends StatelessWidget {
  final Plant plant;

  const PlantCard({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(10),
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
                      plant.latin, 
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Row(
                      children: [
                        Icon(Icons.thermostat),
                        Icon(Icons.water_drop_sharp),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.info_outline),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
