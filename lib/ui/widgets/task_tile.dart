import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';

class TastTile extends StatelessWidget {
  const TastTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            decoration: task.isDone! ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: (value) => _onCheckboxChanged(context, value),
      ),
      onLongPress: () => _onTileLongPress(context),
    );
  }

  void _onCheckboxChanged(BuildContext context, bool? value) {
    if (!task.isRemoved!) context.read<TasksBloc>().add(UpdateTask(task: task));
  }

  void _onTileLongPress(BuildContext context) => context
      .read<TasksBloc>()
      .add(task.isRemoved! ? DeleteTask(task: task) : RemoveTask(task: task));
}
