import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primarywhite = MaterialColor(
    0xFFFFFFFF,
    <int, Color>{
      50: Color(0xFFFFFFFF),
      100: Color(0xFFFFFFFF),
      200: Color(0xFFFFFFFF),
      300: Color(0xFFFFFFFF),
      400: Color(0xFFFFFFFF),
      500: Color(0xFFFFFFFF),
      600: Color(0xFFFFFFFF),
      700: Color(0xFFFFFFFF),
      800: Color(0xFFFFFFFF),
      900: Color(0xFFFFFFFF),
    },
  );
  static const MaterialColor primaryblack = MaterialColor(
    0xFF2c2c2c,
    <int, Color>{
      50: Color(0xFF2c2c2c),
      100: Color(0xFF2c2c2c),
      200: Color(0xFF2c2c2c),
      300: Color(0xFF2c2c2c),
      400: Color(0xFF2c2c2c),
      500: Color(0xFF2c2c2c),
      600: Color(0xFF2c2c2c),
      700: Color(0xFF2c2c2c),
      800: Color(0xFF2c2c2c),
      900: Color(0xFF2c2c2c),
    },
  );
  static const Color primaryColor = Color(0xffffffff);
  static const Color secondaryColor = Color(0xff2c2c2c);
  static const Color white = Color(0xffffffff);
  static Color fillColor = const Color(0xffffffff);
  static Color shimmerColor = secondaryColor;
  static Color grey = Colors.grey;
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    // grey = isDarkTheme ? Colors.grey : Colors.green;
    fillColor = isDarkTheme ? primaryColor : secondaryColor;
    shimmerColor =
        isDarkTheme ? Colors.grey.withOpacity(0.5) : Colors.grey[400]!;

    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? secondaryColor : primaryColor,
      primarySwatch: isDarkTheme ? primarywhite : primaryblack,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: "Lato",
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: isDarkTheme ? secondaryColor : primaryColor,
      ),
      appBarTheme: AppBarTheme(
          color: isDarkTheme ? secondaryColor : primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: isDarkTheme ? primaryColor : secondaryColor,
          ),
          titleTextStyle: TextStyle(
              color: isDarkTheme ? primaryColor : secondaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold)),
      primaryColor: isDarkTheme ? secondaryColor : primaryColor,
      backgroundColor: isDarkTheme ? secondaryColor : const Color(0xffF1F5FB),
      disabledColor: Colors.grey,
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? primaryColor : secondaryColor),
      cardColor: isDarkTheme ? primaryColor : secondaryColor,
      canvasColor: isDarkTheme ? secondaryColor : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
    );
  }
}
