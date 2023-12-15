import 'package:flutter/material.dart';
import 'package:plantapp/controller/plant_controller.dart';
import 'package:plantapp/controller/coll_controller.dart';

class PlantCollection extends StatefulWidget {
  const PlantCollection({super.key});

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
  const PlantInst({super.key});

  @override
  State<PlantInst> createState() => _PlantInstState();
}

class _PlantInstState extends State<PlantInst> {
  var collCont = CollController();
  var plantCont = PlantController();

  Future<void> loadScreen() async {
    await collCont.loadPlantsFromFile();
    await plantCont.loadPlantsFromAsset();
    setState(() {});
  }

  @override
  void initState() {
    loadScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.67),
            itemCount: collCont.collection.length,
            itemBuilder: (context, index) {
              return Card(
                  margin: const EdgeInsets.all(15),
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
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      collCont.collection[index].nickname,
                                      textAlign: TextAlign.start,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    plantCont
                                        .plants[collCont
                                                .collection[index].databaseId -
                                            1]
                                        .latin,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                )
                              ]))));
            }));
  }
}
