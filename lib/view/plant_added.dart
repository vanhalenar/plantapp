// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:plantapp/controller/plant_controller.dart';
import 'package:plantapp/model/coll_model.dart';
import 'package:plantapp/model/plant_model.dart';
import 'package:plantapp/controller/coll_controller.dart';
import 'package:plantapp/view/plant_profile.dart';

class PlantAdded extends StatefulWidget {
  final Collection plant;
  final Plant plantType;
  final CollController collController;

  const PlantAdded({
    required this.plant,
    required this.collController,
    required this.plantType,
    Key? key,
  }) : super(key: key);

  @override
  PlantAddedState createState() => PlantAddedState();
}

class PlantAddedState extends State<PlantAdded> {
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

  void _deletePlant() async {
    // Retrieve the existing plant data
    Collection existingPlant = await widget.collController.getPlant(widget.plantType.id);

    // Delete the plant using CollController
    await widget.collController.deletePlant(existingPlant);

    if (!context.mounted) return;

    // Close the page after deleting the plant
    Navigator.of(context).pop();
  }

   void _showAddPlantBottomSheet(BuildContext context) {
    TextEditingController nicknameController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height *  0.70, // Set to half of the screen
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget> [
              Text(
                'Photo',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Implement functionality to add a photo
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.camera_alt, color: Colors.grey),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Nickname',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              TextField(
                controller: nicknameController,
                decoration: InputDecoration(
                  hintText: 'Filomena',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Notes',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              SizedBox(height: 8),
              TextField(
                controller: notesController,
                decoration: InputDecoration(
                  hintText: 'birthday present from sydney',
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async{
                                // Retrieve the existing plant data
                  Collection existingPlant = await widget.collController.getPlant(widget.plantType.id);

                  // Update the existing plant with the entered data
                  existingPlant.nickname = nicknameController.text;
                  existingPlant.notes = notesController.text;

                  // Save the updated plant using CollController
                  await widget.collController.updatePlant(existingPlant);

                  if (context.mounted) {
                    setState(() {
                      widget.plant.nickname = existingPlant.nickname;
                      widget.plant.notes = existingPlant.notes;
                    });

                  // Close the bottom sheet
                  Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFBFD7B5), // Background color
                  foregroundColor: Color(0xFF39633D), // Text color
                  padding: EdgeInsets.symmetric(
                      horizontal: 16), // Adjust horizontal padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8), // Adjust border radius as needed
                  ),
                ),
                child: Text('Edit Plant',style: Theme.of(context).textTheme.labelMedium,),
              ),
          ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    int daysUntilNextWatering = widget.collController.calculateDaysUntilNextAction(widget.plant.lastWatered, widget.plantType.wateringPeriod);
    int daysUntilNextFertilizing = widget.collController.calculateDaysUntilNextAction(widget.plant.lastFertilized, widget.plantType.fertilizingPeriod);

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Color(0xFFBFD7B5),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      widget.plantType.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text(
                  //   DateFormat('yyyy-MM-dd').format(widget.plant.datePlanted),
                  //   style: Theme.of(context).textTheme.labelSmall,
                  // ),
                  Text(
                    widget.plant.nickname,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    widget.plantType.latin,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  SizedBox(height: 8), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PlantProfileCard(plant: widget.plantType, collController: widget.collController),
                          ));
                        },
                        child: Icon(
                          Icons.info_outline,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _showAddPlantBottomSheet(context);
                        },
                        child: Icon(
                          Icons.mode_edit,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          _deletePlant(); 
                        },
                        child: Icon(
                          Icons.delete,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 45), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // Adjust space distribution as needed
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF508991), 
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('water in', style: Theme.of(context).textTheme.labelSmall),
                            SizedBox(height: 4),
                            Text('$daysUntilNextWatering', style: Theme.of(context).textTheme.titleLarge),
                            Text('days', style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ),
                      // Fertilize in box
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF9D8858),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('fertilize in', style: Theme.of(context).textTheme.labelSmall),
                            SizedBox(height: 4),
                            Text('$daysUntilNextFertilizing', style: Theme.of(context).textTheme.titleLarge),
                            Text('days', style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 45), 
            Container(
              margin: EdgeInsets.only(bottom: 2, left: 15),
              child: Text(
              'Notes',
              style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25),
              child: Text(
                widget.plant.notes,
                style: Theme.of(context).textTheme.bodyMedium,
                ),
            ),
          ],
        ),
      ),
    );
  }
}
