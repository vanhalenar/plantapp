import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PlantCard(),
    );
  }
}

class PlantCard extends StatelessWidget {
  const PlantCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: SizedBox(
          width: 140,
          height: 170,
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/monstera.jpg'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Johnny"),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Monstera deliciosa"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
