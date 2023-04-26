import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/ui/screens/recycle_bin_screen.dart';
import 'package:flutter_tasks_app/ui/screens/tasks_screen.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case TasksScreen.route:
        return MaterialPageRoute(builder: (context) => const TasksScreen());
      case RecycleBinScreen.route:
        return MaterialPageRoute(
            builder: (context) => const RecycleBinScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Center(
                  child: Text(
                      "OnGenerateRoute is not implemented for ${routeSettings.name}"),
                ));
    }
  }
}
