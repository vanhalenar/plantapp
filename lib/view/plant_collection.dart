// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
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
  var collCont = CollController();
  var plantCont = PlantController();

  Future<void> loadScreen() async {
    await collCont.loadUserCollectionsFromAsset();
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
        appBar: AppBar(title: const Text("User's Collections")),
        body: ListView.builder(
            itemCount: collCont.colls.length,
            itemBuilder: (context, index) => ListTile(
                title: Text(
                  collCont.colls[index].collName,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
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
