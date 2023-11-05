import 'package:flutter/material.dart';
import 'package:plantapp/controller/collection_controller.dart';
import 'package:plantapp/controller/plant_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlantCard(),
    );
  }
}

class PlantCard extends StatefulWidget {
  const PlantCard({super.key});

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  var collectionController = CollectionController();
  var plantController = PlantController();

  Future<void> loadScreen() async {
    await collectionController.loadPlantsFromAsset();
    await plantController.loadPlantsFromAsset();
    setState(() {});
  }

  @override
  void initState() {
    loadScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/monstera.jpg'),
                        radius: 40,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          collectionController.tasks[index].nickname,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          plantController
                              .plants[
                                  collectionController.tasks[index].databaseId -
                                      1]
                              .latin,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: FilledButton.tonal(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        collectionController.blueOrBrown(
                                            collectionController.tasks[index])),
                              ),
                              onPressed: onpressed,
                              child: Text(
                                collectionController.waterOrFertilize(
                                    collectionController.tasks[index]),
                                style: Theme.of(context).textTheme.labelMedium,
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: collectionController.tasks.length,
        ),
      ),
    );
  }
}

void onpressed() {}
