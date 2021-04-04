import 'package:flutter/material.dart';
import 'package:hoppy/core/core.dart';

final appBarTheme = const AppBarTheme(
  centerTitle: true,
  elevation: 1,
);

final bottomBarTheme = const BottomNavigationBarThemeData(
  type: BottomNavigationBarType.fixed,
  showSelectedLabels: false,
  showUnselectedLabels: false,
  selectedIconTheme: IconThemeData(
    size: 26,
  ),
  unselectedIconTheme: IconThemeData(
    size: 26,
  ),
);

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    primary: kPrimaryColor,
    onPrimary: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: kPrimaryColor,
    accentColor: kPrimaryColor,
    errorColor: kRedColor,
    scaffoldBackgroundColor: kLightBackgroundColor,
    backgroundColor: kLightDarkerBackgroundColor,
    cardColor: kLightCardColor,
    bottomAppBarTheme: BottomAppBarTheme(
      color: kLightBackgroundColor,
    ),
    appBarTheme: appBarTheme.copyWith(
      iconTheme: IconThemeData(
        color: kLightContentColor,
        opacity: 0.8,
      ),
      backgroundColor: kLightBackgroundColor,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: 'SFPro',
              color: kLightContentColor,
            ),
          ),
    ),
    dividerColor: Color(0xFFA0A0A0),
    bottomNavigationBarTheme: bottomBarTheme.copyWith(
      backgroundColor: kLightBackgroundColor,
      selectedItemColor: kLightContentColor,
      unselectedItemColor: kLightContentColor.withOpacity(0.32),
    ),
    textTheme: Theme.of(context)
        .textTheme
        .apply(
          bodyColor: kLightContentColor,
          fontFamily: 'SFPro',
        )
        .copyWith(
          bodyText2: TextStyle(
            color: kLightContentColor.withOpacity(0.6),
          ),
        ),
    iconTheme: IconThemeData(
      color: kLightContentColor,
      opacity: 0.8,
    ),
    elevatedButtonTheme: elevatedButtonTheme,
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: kPrimaryColor,
    accentColor: kPrimaryColor,
    errorColor: kRedColor,
    scaffoldBackgroundColor: kDarkBackgroundColor,
    backgroundColor: kDarkDarkerBackgroundColor,
    cardColor: kDarkCardColor,
    iconTheme: IconThemeData(
      color: kDarkContentColor,
      opacity: 0.8,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: kDarkCardColor,
    ),
    appBarTheme: appBarTheme.copyWith(
      iconTheme: IconThemeData(
        color: kDarkContentColor,
        opacity: 0.8,
      ),
      shadowColor: Colors.white.withOpacity(0.25),
      backgroundColor: kDarkCardColor,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: TextStyle(
              color: kDarkContentColor,
            ),
          ),
    ),
    dividerColor: Color(0xFFA0A0A0),
    bottomNavigationBarTheme: bottomBarTheme.copyWith(
      backgroundColor: kDarkCardColor,
      selectedItemColor: kDarkContentColor,
      unselectedItemColor: kDarkContentColor.withOpacity(0.35),
    ),
    textTheme: Theme.of(context)
        .textTheme
        .apply(
          bodyColor: kDarkContentColor,
          fontFamily: 'SFPro',
        )
        .copyWith(
          bodyText2: TextStyle(
            color: kDarkContentColor.withOpacity(0.6),
          ),
        ),
    elevatedButtonTheme: elevatedButtonTheme,
  );
}
