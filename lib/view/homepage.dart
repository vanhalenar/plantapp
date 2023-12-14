import 'package:flutter/material.dart';
import 'package:plantapp/controller/task_controller.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var taskController = TaskController();
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
          sizeFactor: animation,
          axis: Axis.horizontal,
          child: const RemoveTaskCard());
    }, duration: const Duration(milliseconds: 300));
    taskController.removeTask(taskController.tasks[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: taskController.loadPlantsFromFile(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                  height: 300,
                  child: AnimatedList(
                    key: _key,
                    scrollDirection: Axis.horizontal,
                    initialItemCount: taskController.tasks.length,
                    itemBuilder: (context, index, animation) {
                      return SizeTransition(
                          sizeFactor: animation,
                          child: TaskCard(taskController, index, _removeItem));
                    },
                  ));
            } else {
              return const Text("still loading");
            }
          })),
    );
  }
}

class TaskCard extends StatelessWidget {
  const TaskCard(this.taskController, this.index, this._removeItem,
      {super.key});

  final TaskController taskController;
  final int index;
  final Function(int) _removeItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/monstera.jpg'),
                radius: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  taskController.tasks[index].nickname,
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  taskController
                      .plants[taskController.tasks[index].databaseId - 1].latin,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FilledButton.tonal(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            taskController
                                .blueOrBrown(taskController.tasks[index])),
                      ),
                      onPressed: () {
                        _removeItem(index);
                      },
                      child: Text(
                        taskController
                            .waterOrFertilize(taskController.tasks[index]),
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RemoveTaskCard extends StatelessWidget {
  const RemoveTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 150,
          child: Column(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/monstera.jpg'),
                radius: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "done",
                  style: Theme.of(context).textTheme.titleLarge,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "done",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FilledButton.tonal(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.green),
                      ),
                      onPressed: () {},
                      child: Text(
                        "done",
                        style: Theme.of(context).textTheme.labelMedium,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
