import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/ui/widgets/tasks_list.dart';
import 'package:flutter_tasks_app/utils/formatter.dart';

import '../../models/task.dart';

class PendingTasksScreen extends StatefulWidget {
  static const String route = "/pending-tasks";

  const PendingTasksScreen({Key? key}) : super(key: key);

  @override
  State<PendingTasksScreen> createState() => _PendingTasksScreenState();
}

class _PendingTasksScreenState extends State<PendingTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (_, state) {
        final List<Task> tasks = state.pendingTasks;

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
}
