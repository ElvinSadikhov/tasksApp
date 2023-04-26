import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/ui/widgets/main_drawer.dart';
import 'package:flutter_tasks_app/ui/widgets/tasks_list.dart';

class RecycleBinScreen extends StatelessWidget {
  static const String route = "/recycle-bin";

  const RecycleBinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recycle Bin"),
      ),
      drawer: const MainDrawer(),
      body: BlocBuilder<TasksBloc, TasksState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Chip(
                  label: Text(
                    "Tasks",
                  ),
                ),
              ),
              TasksList(taskList: state.removedTasks)
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
