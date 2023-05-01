import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/consts/app_strings.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/services/guid_gen.dart';

class AddTaskPanel extends StatefulWidget {
  const AddTaskPanel({Key? key}) : super(key: key);

  @override
  State<AddTaskPanel> createState() => _AddTaskPanelState();
}

class _AddTaskPanelState extends State<AddTaskPanel> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
    final task = Task(
        id: GUIDGen.generate(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        date: DateTime.now().toString());
    context.read<TasksBloc>().add(AddTask(task: task));
    Navigator.pop(context);
  }
}
