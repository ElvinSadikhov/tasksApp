part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final AppTheme appTheme;
  const ThemeState({required this.appTheme});
  @override
  List<Object> get props => [appTheme];
}

class LightThemeState extends ThemeState {
  const LightThemeState() : super(appTheme: AppTheme.light);
}

class DarkThemeState extends ThemeState {
  const DarkThemeState() : super(appTheme: AppTheme.dark);
}
