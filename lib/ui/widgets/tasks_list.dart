import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';

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
          return ListTile(
            title: Text(task.title),
            trailing: Checkbox(
              value: task.isDone,
              onChanged: (value) =>
                  context.read<TasksBloc>().add(UpdateTask(task: task)),
            ),
            onLongPress: () =>
                context.read<TasksBloc>().add(DeleteTask(task: task)),
          );
        },
      ),
    );
  }
}
