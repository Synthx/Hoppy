import 'package:flutter/material.dart';
import 'package:hoppy/config/colors/light_colors.dart';

class Themes {
  // shared theme data
  static Color primaryColor = const Color(0xFFFB6E3B);
  static BottomNavigationBarThemeData bottomBarTheme =
      const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedIconTheme: const IconThemeData(
      size: 26,
    ),
    unselectedIconTheme: const IconThemeData(
      size: 26,
    ),
  );

  static AppBarTheme appBarTheme = const AppBarTheme(
    centerTitle: true,
    elevation: 1,
  );

  // light theme
  static ThemeData light = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: LightThemeColors.background,
    bottomNavigationBarTheme: bottomBarTheme.copyWith(
      backgroundColor: LightThemeColors.card,
      selectedItemColor: primaryColor,
      unselectedItemColor: LightThemeColors.mediumText,
    ),
    appBarTheme: appBarTheme.copyWith(
      brightness: Brightness.light,
      color: LightThemeColors.card,
      iconTheme: IconThemeData(
        color: LightThemeColors.text,
      ),
      textTheme: TextTheme(
        headline6: TextStyle(
          color: LightThemeColors.text,
        ),
      ),
    ),
    dividerColor: LightThemeColors.divider,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
    textTheme: TextTheme(
      headline4: TextStyle(
        color: LightThemeColors.text,
        fontSize: 20,
      ),
      bodyText1: TextStyle(
        color: LightThemeColors.text,
        fontWeight: FontWeight.normal,
      ),
      bodyText2: TextStyle(
        color: LightThemeColors.mediumText,
      ),
    ),
  );

  // dark theme
  static ThemeData dark = ThemeData(
    primaryColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor,
        onPrimary: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}
