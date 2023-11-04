import 'package:flutter/material.dart';
import 'controller/collection_controller.dart';

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
  var controller = CollectionController();

  Future<void> loadScreen() async {
    await controller.loadPlantsFromAsset();
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
        height: 270,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/monstera.jpg'),
                        radius: 40,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          controller.plants[index].nickname,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Monstera",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      FilledButton.tonal(
                          onPressed: onpressed,
                          child: Text(
                            "Water me",
                            style: Theme.of(context).textTheme.labelMedium,
                          )),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: controller.plants.length,
        ),
      ),
    );
  }
}

void onpressed() {}
