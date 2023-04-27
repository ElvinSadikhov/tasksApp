import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/ui/screens/recycle_bin_screen.dart';
import 'package:flutter_tasks_app/ui/screens/tasks_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              color: Colors.grey,
              child: Text("Task Drawer",
                  style: Theme.of(context).textTheme.headline5),
            ),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () => _onMyTasksTileTap(context),
                      child: ListTile(
                          leading: const Icon(Icons.folder_special),
                          title: const Text("My Tasks"),
                          trailing: Text(state.allTasks.length.toString())),
                    ),
                    const Divider(),
                    GestureDetector(
                      onTap: () => _onRecycleBinTileTap(context),
                      child: ListTile(
                          leading: const Icon(Icons.delete),
                          title: const Text("Bin"),
                          trailing: Text(state.removedTasks.length.toString())),
                    ),
                  ],
                );
              },
            ),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return Switch(
                    value: state is DarkThemeState,
                    onChanged: (value) {
                      context
                          .read<ThemeBloc>()
                          .add(value ? SwitchOnEvent() : SwitchOffEvent());
                    });
              },
            )
          ],
        ),
      ),
    );
  }

  void _onMyTasksTileTap(BuildContext context) =>
      Navigator.pushReplacementNamed(context, TasksScreen.route);
  void _onRecycleBinTileTap(BuildContext context) =>
      Navigator.pushReplacementNamed(context, RecycleBinScreen.route);
}
