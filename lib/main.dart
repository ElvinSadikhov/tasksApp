import 'package:flutter/material.dart';
import 'package:flutter_tasks_app/blocs/bloc_exports.dart';
import 'package:flutter_tasks_app/config/main_configuration.dart';
import 'package:flutter_tasks_app/consts/app_themes.dart';
import 'package:flutter_tasks_app/ui/screens/home_screen.dart';
import 'package:flutter_tasks_app/utils/app_router.dart';

import 'ui/screens/pending_tasks_screen.dart';

void main() async {
  await MainConfiguration.configure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TasksBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state is DarkThemeState
                ? AppThemes.darkhemeData
                : AppThemes.lightThemeData,
            home: const HomeScreen(),
            onGenerateRoute: AppRouter.onGenerateRoute,
          );
        },
      ),
    );
  }
}
