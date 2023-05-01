import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/consts/app_strings.dart';
import 'package:flutter_tasks_app/models/task.dart';

class EditTaskPanel extends StatefulWidget {
  final Task oldTask;
  const EditTaskPanel({Key? key, required this.oldTask}) : super(key: key);

  @override
  State<EditTaskPanel> createState() => _EditTaskPanelState();
}

class _EditTaskPanelState extends State<EditTaskPanel> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.oldTask.title);
    _descriptionController =
        TextEditingController(text: widget.oldTask.description);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(AppStrings.addTask, style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: TextField(
                  controller: _titleController,
                  autofocus: true,
                  decoration: const InputDecoration(
                    label: Text(AppStrings.title),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              TextField(
                controller: _descriptionController,
                autofocus: true,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  label: Text(AppStrings.description),
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => _onCancelBtnTap(context),
                      child: const Text(AppStrings.cancel)),
                  ElevatedButton(
                      onPressed: () => _onAddBtnTap(context),
                      child: const Text(AppStrings.add)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCancelBtnTap(BuildContext context) {
    Navigator.pop(context);
  }

  void _onAddBtnTap(BuildContext context) {
    final editedTask = Task(
      id: widget.oldTask.id,
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      date: DateTime.now().toString(),
      isDone: false,
      isFavorite: widget.oldTask.isFavorite,
    );
    context
        .read<TasksBloc>()
        .add(EditTask(oldTask: widget.oldTask, newTask: editedTask));
    Navigator.pop(context);
  }
}
