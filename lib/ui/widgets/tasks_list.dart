import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/ui/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: taskList.length,
        itemBuilder: (context, index) {
          final Task task = taskList[index];
          return TastTile(task: task);
        },
      ),
    );
  }
}
