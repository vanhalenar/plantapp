// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plantapp/model/plant_model.dart';
import 'package:plantapp/model/coll_model.dart';
import 'package:plantapp/controller/coll_controller.dart';
import 'package:plantapp/view/plant_added.dart';

class PlantProfileCard extends StatefulWidget {
  final Plant plant;
  final CollController collController;

  const PlantProfileCard({
    required this.plant,
    required this.collController,
    Key? key,
  }) : super(key: key);

  @override
  PlantProfileCardState createState() => PlantProfileCardState();
}

class PlantProfileCardState extends State<PlantProfileCard> {
  
  void _showAddPlantBottomSheet(BuildContext context) {
    TextEditingController nicknameController = TextEditingController();
    TextEditingController datePlantedController = TextEditingController();
    TextEditingController lastWateredController = TextEditingController();
    TextEditingController lastFertilizedController = TextEditingController();
    TextEditingController notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height *  0.75, // Set to half of the screen
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
                'Date Planted',
                style: Theme.of(context).textTheme.titleSmall,
              ),
               TextField(
                controller: datePlantedController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: datePlantedController.text.isNotEmpty
                        ? DateTime.parse(datePlantedController.text)
                        : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    // Format the selected date and update the controller
                    String formattedDate = selectedDate.toLocal().toString();
                    datePlantedController.text = formattedDate;
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                'Last Watered',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextField(
                controller: lastWateredController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: lastWateredController.text.isNotEmpty
                        ? DateTime.parse(lastWateredController.text)
                        : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    // Format the selected date and update the controller
                    String formattedDate = selectedDate.toLocal().toString();
                    lastWateredController.text = formattedDate;
                  }
                },
              ),
              SizedBox(height: 20),
              Text(
                'Last Fertilized',
                style: Theme.of(context).textTheme.titleSmall,
              ),
               TextField(
                controller: lastFertilizedController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: lastFertilizedController.text.isNotEmpty
                        ? DateTime.parse(lastFertilizedController.text)
                        : DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                  );

                  if (selectedDate != null) {
                    // Format the selected date and update the controller
                    String formattedDate = selectedDate.toLocal().toString();
                    lastFertilizedController.text = formattedDate;
                  }
                },
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
                   // Convert text representations of dates to DateTime objects
                  DateTime datePlanted = datePlantedController.text.isNotEmpty
                      ? DateTime.parse(datePlantedController.text)
                      : DateTime.now();

                  DateTime lastWatered = lastWateredController.text.isNotEmpty
                      ? DateTime.parse(lastWateredController.text)
                      : DateTime.now();

                  DateTime lastFertilized = lastFertilizedController.text.isNotEmpty
                      ? DateTime.parse(lastFertilizedController.text)
                      : DateTime.now();
                      
                  // Create a Collection object with the entered data
                  Collection newPlant = Collection(
                    databaseId: widget.plant.id, 
                    nickname: nicknameController.text,
                    datePlanted: datePlanted,
                    lastWatered: lastWatered,
                    lastFertilized: lastFertilized,
                    notes: notesController.text,
                  );

                  // Save the new plant using CollController
                  await widget.collController.savePlant(newPlant);

                  if (!context.mounted) return;

                  // Close the bottom sheet
                  Navigator.of(context).pop();

                  // Navigate to the new screen (plant_added.dart)
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PlantAdded(plant: newPlant, collController: widget.collController, plantType: widget.plant)),
                  );
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
                child: Text('Add Plant'),
              ),
          ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      widget.plant.image,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      widget.plant.latin,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        _showAddPlantBottomSheet(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFBFD7B5),
                        ),
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(
                              color: Color(0xFF39633D),
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(
                        bottom: 2), // Adding margin only to the bottom
                    child: Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Names',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.names,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Watering',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.watering,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Fertilizing',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.fertilizing,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Difficulty',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.difficulty,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Light',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.light,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Tips',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.tips,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.only(bottom: 2),
                    child: Text(
                      'Historical & Ethnic Information',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      widget.plant.information,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
