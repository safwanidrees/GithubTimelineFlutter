import 'package:flutter/material.dart';
import 'package:github_flutter/core/repository/theme_repo.dart';

class ThemeBloc with ChangeNotifier {
  final _themeRepository = ThemeRepository();
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    _themeRepository.setDarkTheme(value);
    notifyListeners();
  }

  Future<void> getCurrentAppTheme() async {
    _darkTheme = await ThemeRepository().getTheme();
    notifyListeners();
  }
}
