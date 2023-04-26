import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/blocs/tasks_bloc_observer.dart';
import 'package:flutter_tasks_app/utils/app_router.dart';
import 'package:path_provider/path_provider.dart';

import 'ui/screens/tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  Bloc.observer = TasksBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final TasksBloc _tasksBloc = TasksBloc();

  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _tasksBloc,
      child: MaterialApp(
        title: 'Flutter Tasks App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TasksScreen(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
