import 'package:flutter/material.dart';
import 'package:hoppy/theme/theme.dart';

final themeData = ThemeData(
  useMaterial3: true,
  fontFamily: 'Gilroy',
  brightness: Brightness.light,
  splashFactory: NoSplash.splashFactory,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColor,
  cardColor: kCardColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.light,
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    background: kBackgroundColor,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: false,
    backgroundColor: kBackgroundColor,
    surfaceTintColor: Colors.transparent,
    shadowColor: Colors.black.withOpacity(0.4),
    elevation: 1,
    titleSpacing: 0,
    titleTextStyle: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: kSecondaryColor,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: kSecondaryColor,
    labelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    ),
    unselectedLabelColor: kSecondaryColor,
    unselectedLabelStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
    indicator: UnderlineTabIndicator(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(
        color: kPrimaryColor,
        width: 2,
      ),
    ),
    indicatorColor: kPrimaryColor,
    indicatorSize: TabBarIndicatorSize.label,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 1,
    backgroundColor: kBackgroundColor,
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: kSecondaryColor,
    showSelectedLabels: false,
    showUnselectedLabels: false,
  ),
  iconTheme: const IconThemeData(
    color: kTextColor,
  ),
  dividerTheme: const DividerThemeData(
    color: kPrimaryColor,
    thickness: 2,
    space: 0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all(EdgeInsets.zero),
      minimumSize: MaterialStateProperty.all(Size.zero),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontFamily: 'Gobold',
      fontSize: 30,
      fontWeight: FontWeight.w700,
      color: kTextColor,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Gobold',
      fontSize: 25,
      fontWeight: FontWeight.w500,
      color: kTextColor,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Gobold',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: kTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: kTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      color: kTextColor,
    ),
  ),
);
