import 'package:github_flutter/core/service/theme_service.dart';

class ThemeRepository {
  final _themeService = ThemeService();

  setDarkTheme(bool value) => _themeService.setDarkTheme(value);

  Future<bool> getTheme() => _themeService.getTheme();
}
