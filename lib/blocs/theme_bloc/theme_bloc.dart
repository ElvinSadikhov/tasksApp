import 'package:equatable/equatable.dart';
import 'package:flutter_tasks_app/models/enums/app_theme.dart';

import '../bloc_exports.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const LightThemeState()) {
    on<SwitchOnEvent>(_onSwitchOnEvent);
    on<SwitchOffEvent>(_onSwitchOffEvent);
  }

  void _onSwitchOnEvent(SwitchOnEvent event, Emitter<ThemeState> emit) {
    emit(const DarkThemeState());
  }

  void _onSwitchOffEvent(SwitchOffEvent event, Emitter<ThemeState> emit) {
    emit(const LightThemeState());
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    String? appThemeName = json["appThemeName"] as String?;
    if (appThemeName == null) return null;
    switch (AppTheme.values.firstWhere((e) => e.name == appThemeName)) {
      case AppTheme.light:
        return const LightThemeState();
      case AppTheme.dark:
        return const DarkThemeState();
      default:
        return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return <String, dynamic>{"appThemeName": state.appTheme.name};
  }
}
