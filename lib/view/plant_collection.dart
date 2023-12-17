// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:plantapp/model/plant_model.dart';
import 'package:plantapp/model/usercoll_model.dart';
import 'package:plantapp/controller/plant_controller.dart';
import 'package:plantapp/controller/usercoll_controller.dart';

class PlantCollection extends StatefulWidget {
  const PlantCollection({Key? key}) : super(key: key);

  @override
  State<PlantCollection> createState() => _PlantCollectionState();
}

class _PlantCollectionState extends State<PlantCollection> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: PlantInst());
  }
}

class PlantInst extends StatefulWidget {
  const PlantInst({Key? key}) : super(key: key);

  @override
  State<PlantInst> createState() => _PlantInstState();
}

class _PlantInstState extends State<PlantInst> {
  var collCont = UserCollController();
  var plantCont = PlantController();

  int selectedCollectionIndex = -1;

  TextEditingController usercollsController = TextEditingController();

  Future<void> loadScreen() async {
    await collCont.loadCollectionsFromFile();
    await plantCont.loadPlantsFromAsset();
    setState(() {});
  }

  @override
  void initState() {
    loadScreen();
    super.initState();
  }

  void _showCollectionSettings(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height *  0.5, // Set to half of the screen
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget> [
              ElevatedButton(
                onPressed: () => _dialogChangeName(context),
                child: Text('Rename Collection'),
              ),
              ElevatedButton(
                onPressed: () => _dialogDeleteColl(context),
                child: Text('Delete Collection'),
              ),
              ElevatedButton(
                onPressed: () => _dialogAddPlant(context),
                child: Text('Add Plant To Collection'),
              ),
              ElevatedButton(
                onPressed: () => _dialogRemovePlant(context),
                child: Text('Remove Plant From Collection'),
              ),
          ],
          ),
        );
      },
    );
  }

  Future<void> _dialogChangeName(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rename Collection'),
          content: TextField(
                    controller: usercollsController,
                    decoration: InputDecoration(
                      hintText: 'New Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(),
                    ),
                  ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Rename'),
              onPressed: () async {
                await collCont.updateCollection(usercollsController.text, selectedCollectionIndex);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogDeleteColl(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Collection'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () async {
                await collCont.deleteCollection(selectedCollectionIndex);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogAddPlant(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          
          title: const Text('Add Plant'),
          content: Expanded(
            child: ListView.builder(
              itemCount: collCont.colls[0].plantIds.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () async {
                    await collCont.addPlantToCollection(index, selectedCollectionIndex);
                    Navigator.of(context).pop();
                  },
                  child: Text('${collCont.colls[index].plantIds}'),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _dialogRemovePlant(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Plant'),
          content: Expanded(
            child: ListView.builder(
              itemCount: collCont.colls[selectedCollectionIndex].plantIds.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () async {
                    await collCont.removePlantFromCollection(index, selectedCollectionIndex);
                    Navigator.of(context).pop();
                  },
                  child: Text('${collCont.colls[index].plantIds}'),
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User's Collections")),
        body: ListView.builder(
            itemCount: collCont.colls.length,
            itemBuilder: (context, index) => ListTile(
                title: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCollectionIndex = index;
                    });
                    _showCollectionSettings(context);
                  },
                  child: Row(mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        collCont.colls[index].collName,
                        style: const TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.settings),
                  ],),
                ),
                subtitle: _contentGridView(index))));
  }

  Widget _contentGridView(int cindex) {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.67),
        itemCount: collCont.colls[cindex].plantIds.length,
        itemBuilder: (context, index) {
          return Card(
              //color: Colors.green[300],
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                      width: 140,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    alignment: Alignment.center,
                                    child: const Image(
                                      image: AssetImage(
                                          'assets/images/monstera.jpg'),
                                      height: 140,
                                      width: 140,
                                      fit: BoxFit.fitWidth,
                                    ))),
                            const SizedBox(height: 9),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  collCont.colls[cindex].plantNames[index],
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                      height: 1,
                                      leadingDistribution:
                                          TextLeadingDistribution.even),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                plantCont
                                    .plants[
                                        collCont.colls[cindex].plantIds[index] -
                                            1]
                                    .latin,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black54,
                                    height: 1.0,
                                    leadingDistribution:
                                        TextLeadingDistribution.even),
                              ),
                            )
                          ]))));
        });
  }
}
