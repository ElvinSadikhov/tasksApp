import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/ui/widgets/edit_task_panel.dart';
import 'package:flutter_tasks_app/ui/widgets/popup_menu.dart';
import 'package:intl/intl.dart';

class TastTile extends StatelessWidget {
  const TastTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        children: [
          Icon(task.isFavorite! ? Icons.star : Icons.star_outline),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    decoration:
                        task.isDone! ? TextDecoration.lineThrough : null),
              ),
              Text(DateFormat()
                  .add_yMMMd()
                  .add_Hms()
                  .format(DateTime.parse(task.date)))
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Checkbox(
                value: task.isDone,
                onChanged: (value) => _onCheckboxChanged(context, value),
              ),
              PopupMenu(
                task: task,
                onDeleteTap: _onRemoveOrDelete,
                onBookmarkTap: _onAddOrRemoveBookmark,
                onEditTap: _onEdit,
                onRestoreTap: _onRestore,
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onCheckboxChanged(BuildContext context, bool? value) {
    if (!task.isRemoved!) context.read<TasksBloc>().add(UpdateTask(task: task));
  }

  void _onRemoveOrDelete(BuildContext context) => context
      .read<TasksBloc>()
      .add(task.isRemoved! ? DeleteTask(task: task) : RemoveTask(task: task));

  void _onAddOrRemoveBookmark(BuildContext context) =>
      context.read<TasksBloc>().add(task.isFavorite!
          ? RemoveTaskFromBookmarks(task: task)
          : AddTaskToBookmarks(task: task));

  void _onEdit(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => EditTaskPanel(oldTask: task),
      );
    });
  }

  void _onRestore(BuildContext context) =>
      context.read<TasksBloc>().add(RestoreTask(task: task));
}
