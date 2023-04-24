import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/models/task.dart';
import 'package:flutter_tasks_app/services/guid_gen.dart';

class AddTaskPanel extends StatefulWidget {
  const AddTaskPanel({Key? key}) : super(key: key);

  @override
  State<AddTaskPanel> createState() => _AddTaskPanelState();
}

class _AddTaskPanelState extends State<AddTaskPanel> {
  final TextEditingController _titleController = TextEditingController();

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
              const Text("Add Task", style: TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              TextField(
                controller: _titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  label: Text("Title"),
                  border: OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => _onCancelBtnTap(context),
                      child: const Text("Cancel")),
                  ElevatedButton(
                      onPressed: () => _onAddBtnTap(context),
                      child: const Text("Add")),
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
    final task =
        Task(id: GUIDGen.generate(), title: _titleController.text.trim());
    context.read<TasksBloc>().add(AddTask(task: task));
    Navigator.pop(context);
  }
}
