import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationApp(),
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
            titleLarge: GoogleFonts.josefinSans(
              fontSize: 24,
            ),
            titleMedium: GoogleFonts.josefinSans(
              fontSize: 18,
              color: const Color(0xAA6E7487),
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
        indicatorColor: const Color(0xFFBFD7B5),
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
        const HomePage(),
        const Achievements(),
        const AddPlant(),
        const Calendar(),
        const Profile(),
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

class AddPlant extends StatelessWidget {
  const AddPlant({super.key});

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

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
