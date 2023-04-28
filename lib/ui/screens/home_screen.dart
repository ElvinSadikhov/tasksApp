import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/models/tab_screen.dart';
import 'package:flutter_tasks_app/ui/screens/completed_tasks_screen.dart';
import 'package:flutter_tasks_app/ui/screens/pending_tasks_screen.dart';
import 'package:flutter_tasks_app/ui/widgets/add_task_panel.dart';
import 'package:flutter_tasks_app/ui/widgets/main_drawer.dart';

import 'favorite_tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TabScreen> _pageDetails = [
    TabScreen(screen: const PendingTasksScreen(), title: "Pending Tasks"),
    TabScreen(screen: const CompletedTasksScreen(), title: "Completed Tasks"),
    TabScreen(screen: const FavoriteTasksScreen(), title: "Favorite Tasks"),
  ];

  int _currentTabIndex = 0;

  void _addTask(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const AddTaskPanel(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDetails[_currentTabIndex].title),
        actions: [
          IconButton(
            onPressed: () => _addTask(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const MainDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTask(context),
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
        onTap: (value) {
          setState(() {
            _currentTabIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.label), label: "Pending Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.done), label: "Completed Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorite Tasks"),
        ],
      ),
      body: _pageDetails[_currentTabIndex].screen,
    );
  }
}
