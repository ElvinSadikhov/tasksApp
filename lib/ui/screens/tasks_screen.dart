import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/ui/widgets/main_drawer.dart';
import 'package:flutter_tasks_app/ui/widgets/add_task_panel.dart';
import 'package:flutter_tasks_app/ui/widgets/tasks_list.dart';

import '../../models/task.dart';

class TasksScreen extends StatefulWidget {
  static const String route = "/tasks";

  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (_, state) {
        final List<Task> tasks = state.allTasks;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks App'),
            actions: [
              IconButton(
                onPressed: () => _addTask(context),
                icon: const Icon(Icons.add),
              )
            ],
          ),
          drawer: const MainDrawer(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(
                  label: Text(
                    "${tasks.length} ${tasks.length == 1 ? "Task" : "Tasks"}",
                  ),
                ),
              ),
              TasksList(taskList: tasks)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _addTask(context),
            tooltip: 'Add Task',
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskPanel(),
    );
  }
}
