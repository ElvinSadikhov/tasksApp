import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/consts/app_strings.dart';
import 'package:flutter_tasks_app/models/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final Function(BuildContext context)? onDeleteTap;
  final Function(BuildContext context)? onBookmarkTap;
  final Function(BuildContext context)? onEditTap;
  final Function(BuildContext context)? onRestoreTap;

  const PopupMenu({
    Key? key,
    required this.task,
    this.onDeleteTap,
    this.onBookmarkTap,
    this.onEditTap,
    this.onRestoreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder:
            task.isRemoved! ? _removedTaskMenuBuilder : _activeTaskMenuBuilder);
  }

  List<PopupMenuEntry<dynamic>> _removedTaskMenuBuilder(BuildContext context) =>
      [
        PopupMenuItem(
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.delete_forever),
              label: const Text(AppStrings.deleteForever)),
          onTap: () => onDeleteTap?.call(context),
        ),
        PopupMenuItem(
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.restore),
              label: const Text(AppStrings.restore)),
          onTap: () => onRestoreTap?.call(context),
        )
      ];

  List<PopupMenuEntry<dynamic>> _activeTaskMenuBuilder(BuildContext context) =>
      [
        PopupMenuItem(
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.edit),
              label: const Text(AppStrings.edit)),
          onTap: () => onEditTap?.call(context),
        ),
        PopupMenuItem(
            child: TextButton.icon(
                onPressed: null,
                icon: Icon(task.isFavorite!
                    ? Icons.bookmark_remove
                    : Icons.bookmark_add_outlined),
                label: Text(task.isFavorite!
                    ? AppStrings
                        .removeFromBookmarks // todo: add to strings class
                    : AppStrings.addToBookmarks)),
            onTap: () => onBookmarkTap?.call(context)),
        PopupMenuItem(
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(Icons.delete),
              label: const Text(AppStrings.delete)),
          onTap: () => onDeleteTap?.call(context),
        )
      ];
}
