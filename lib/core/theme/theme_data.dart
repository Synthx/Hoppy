import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hoppy/core/core.dart';

final appBarTheme = const AppBarTheme(
  centerTitle: true,
  elevation: 1,
);

final bottomBarTheme = const BottomNavigationBarThemeData(
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
  final font = GoogleFonts.montserrat();
  return ThemeData.light().copyWith(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kLightBackgroundColor,
    backgroundColor: kLightDarkerBackgroundColor,
    cardColor: kLightCardColor,
    appBarTheme: appBarTheme.copyWith(
      iconTheme: IconThemeData(
        color: kLightContentColor,
        opacity: 0.8,
      ),
      backgroundColor: kLightCardColor,
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: TextStyle(
              fontFamily: font.fontFamily,
              color: kLightContentColor,
            ),
          ),
    ),
    dividerColor: Color(0xFFA0A0A0),
    bottomNavigationBarTheme: bottomBarTheme.copyWith(
      backgroundColor: kLightCardColor,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kLightContentColor.withOpacity(0.6),
    ),
    textTheme: GoogleFonts.montserratTextTheme()
        .apply(
          bodyColor: kLightContentColor,
        )
        .copyWith(
          bodyText2: TextStyle(
            fontFamily: font.fontFamily,
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

ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kDarkBackgroundColor,
  cardColor: kDarkCardColor,
  iconTheme: IconThemeData(
    color: kDarkContentColor,
  ),
);
