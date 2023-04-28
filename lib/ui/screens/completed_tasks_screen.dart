import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/ui/widgets/add_task_panel.dart';
import 'package:flutter_tasks_app/ui/widgets/tasks_list.dart';
import 'package:flutter_tasks_app/utils/formatter.dart';

import '../../models/task.dart';

class CompletedTasksScreen extends StatefulWidget {
  static const String route = "/completed-tasks";

  const CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (_, state) {
        final List<Task> tasks = state.completedTasks;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Chip(
                label: Text(
                  Formatter.formatTasksCounterTitle(state),
                ),
              ),
            ),
            TasksList(taskList: tasks)
          ],
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
