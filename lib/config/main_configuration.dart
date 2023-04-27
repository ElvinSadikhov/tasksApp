import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/blocs/tasks_bloc_observer.dart';
import 'package:path_provider/path_provider.dart';

class MainConfiguration {
  MainConfiguration._();

  static Future<void> configure() async {
    WidgetsFlutterBinding.ensureInitialized();
    HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: await getApplicationDocumentsDirectory());
    Bloc.observer = TasksBlocObserver();
  }
}
