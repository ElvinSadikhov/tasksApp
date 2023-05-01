import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/ui/widgets/tasks_list.dart';
import 'package:flutter_tasks_app/utils/formatter.dart';

import '../../models/task.dart';

class FavoriteTasksScreen extends StatefulWidget {
  static const String route = "/favorite-tasks";

  const FavoriteTasksScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteTasksScreen> createState() => _FavoriteTasksScreenState();
}

class _FavoriteTasksScreenState extends State<FavoriteTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (_, state) {
        final List<Task> tasks = state.favoriteTasks;

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
