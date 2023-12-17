// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:plantapp/controller/achievements_controller.dart';
import 'package:plantapp/controller/plant_controller.dart';
import 'package:plantapp/model/achievement_model.dart';
import 'package:plantapp/model/plant_model.dart';

class Achievements extends StatefulWidget {
  const Achievements({super.key});

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  var achievementsController = AchievementsController();
  var plantController = PlantController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: AppBar(
            title: const Text(
              'Achievements',
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            backgroundColor: const Color(0xFFBFD7B5),
            titleSpacing: 10,
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: Future.wait([
                achievementsController.loadAchievementsFromAsset(),
                plantController.loadPlantsFromAsset()
              ]),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Expanded(
                    child: CustomScrollView(
                      scrollDirection: Axis.vertical,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  'In progress',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontSize: 28),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IncompleteAchievementsList(
                            achievementsController, plantController),
                        SliverToBoxAdapter(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Padding(
                                    padding: EdgeInsets.only(top: 24.0),
                                    child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          'Completed',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(fontSize: 28),
                                          textAlign: TextAlign.left,
                                        ))))),
                        CompletedAchievementsList(
                            achievementsController, plantController),
                      ],
                    ),
                  );
                } else {
                  return const Text("Loading data");
                }
              }))
        ],
      ),
    );
  }
}

class IncompleteAchievementsList extends StatelessWidget {
  const IncompleteAchievementsList(
      this.achievementsController, this.plantController,
      {super.key});
  final AchievementsController achievementsController;
  final PlantController plantController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return AchievementCard(
            achievementsController.incompleteAchievements[index],
            plantController.plants[achievementsController
                    .incompleteAchievements[index].databaseId -
                1]);
      }, childCount: achievementsController.incompleteAchievements.length),
    );
  }
}

class CompletedAchievementsList extends StatelessWidget {
  const CompletedAchievementsList(
      this.achievementsController, this.plantController,
      {super.key});
  final AchievementsController achievementsController;
  final PlantController plantController;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return AchievementCard(
            achievementsController.completedAchievements[index],
            plantController.plants[
                achievementsController.completedAchievements[index].databaseId -
                    1]);
      }, childCount: achievementsController.completedAchievements.length),
    );
  }
}

class AchievementCard extends StatelessWidget {
  const AchievementCard(this.achievement, this.plant, {super.key});

  final Achievement achievement;
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: 300,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(plant.image),
                radius: 30,
              ),
              SizedBox(width: 8),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    achievement
                        .achievement, // Displaying the Latin name of the plant
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(achievement.nickname,
                      style: Theme.of(context).textTheme.titleMedium),
                  Padding(padding: EdgeInsets.all(5)),
                  LineProgOrNot(achievement)
                ],
              ),
              Spacer(), // Added a spacer to push the info icon to the right
              Icon(Icons.emoji_events, color: doneOrNot(achievement)),
            ],
          ),
        ),
      ),
    );
  }

  Color doneOrNot(Achievement achievement) {
    if (achievement.current == achievement.max) {
      return ColorScheme.fromSeed(seedColor: Colors.green).primary;
    } else {
      return Color(0xAA6E7487);
    }
  }
}

class LineProgOrNot extends StatelessWidget {
  const LineProgOrNot(this.achievement, {super.key});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    if (achievement.current < achievement.max) {
      return SizedBox(
          height: 10,
          width: 200,
          child: LinearProgressIndicator(
              value: achievement.current / achievement.max));
    } else {
      return const SizedBox(
        height: 10,
        width: 200,
      );
    }
  }
}
