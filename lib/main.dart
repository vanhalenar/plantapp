import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'view/homepage.dart';
import 'view/add_plant.dart';
import 'view/plant_collection.dart';
import 'controller/task_controller.dart';

void main() {
  runApp(const MyApp());
  //seeders, remove when deploying
  var taskController = TaskController();
  taskController.seedFile();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ignore: prefer_const_constructors
      home: NavigationApp(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        textTheme: TextTheme(
            titleLarge: GoogleFonts.josefinSans(
              fontSize: 24,
            ),
            titleMedium: GoogleFonts.josefinSans(
              fontSize: 18,
              color: const Color(0xAA6E7487),
            ),
            labelSmall: GoogleFonts.josefinSans(
              fontSize: 14,
            ),
            labelMedium: GoogleFonts.josefinSans(
              fontSize: 18,
            )),
      ),
    );
  }
}

class NavigationApp extends StatefulWidget {
  const NavigationApp({super.key});

  @override
  State<NavigationApp> createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
              icon: Icon(Icons.emoji_events), label: "Achievements"),
          NavigationDestination(icon: Icon(Icons.add), label: "Add plant"),
          NavigationDestination(
              icon: Icon(Icons.calendar_month), label: "Tasks"),
          NavigationDestination(
              icon: Icon(Icons.account_circle), label: "My plants")
        ],
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      ),
      body: <Widget>[
        const Homepage(),
        const Achievements(),
        const AddPlant(),
        const Calendar(),
        const PlantCollection(),
      ][currentPageIndex],
    );
  }
}

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Calendar extends StatelessWidget {
  const Calendar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
