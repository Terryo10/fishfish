import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark }

class ThemeCubit extends Cubit<AppThemeMode> {
  final SharedPreferences prefs;
  static const String _themeKey = 'theme_mode';

  ThemeCubit(this.prefs) : super(_loadInitialTheme(prefs));

  static AppThemeMode _loadInitialTheme(SharedPreferences prefs) {
    final savedTheme = prefs.getString(_themeKey);
    return savedTheme == AppThemeMode.dark.toString()
        ? AppThemeMode.dark
        : AppThemeMode.light;
  }

  void toggleTheme() {
    final newTheme =
        state == AppThemeMode.light ? AppThemeMode.dark : AppThemeMode.light;
    prefs.setString(_themeKey, newTheme.toString());
    emit(newTheme);
  }
}
