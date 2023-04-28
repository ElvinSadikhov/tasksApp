import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/ui/screens/recycle_bin_screen.dart';
import 'package:flutter_tasks_app/ui/screens/home_screen.dart';
import 'package:flutter_tasks_app/ui/screens/pending_tasks_screen.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PendingTasksScreen.route:
        return MaterialPageRoute(
            builder: (context) => const PendingTasksScreen());
      case RecycleBinScreen.route:
        return MaterialPageRoute(
            builder: (context) => const RecycleBinScreen());
      case HomeScreen.route:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      default:
        return MaterialPageRoute(
            builder: (context) => Center(
                  child: Text(
                      "OnGenerateRoute is not implemented for ${routeSettings.name}"),
                ));
    }
  }
}
