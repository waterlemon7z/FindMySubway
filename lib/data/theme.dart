import 'package:flutter/material.dart';

class ThemeColors {
  final dark = ThemeData(
    primarySwatch: createMaterialColor(Color(0xff000000)),
    scaffoldBackgroundColor: Color(0xff000000),
    dividerColor: Colors.grey,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Color(0xff000000),
      titleTextStyle: TextStyle(
        color: Color(0xffffffff),
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      iconTheme: IconThemeData(
        color: Color(0xffffffff),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xffffffff),
      ),
      bodyLarge: TextStyle(
        color: Color(0xffffffff),
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xffffffff),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xffDD8D54),
      unselectedItemColor: Color(0xff353535),
      backgroundColor: Color(0xff000000),
    ),
    canvasColor: const Color(0xff000000),
    hintColor: const Color(0xffffffff),
    listTileTheme: ListTileThemeData(
      textColor: Color(0xffffffff),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xffffffff),
      ),
    ),
  );

  final light = ThemeData(
    primarySwatch: createMaterialColor(Color(0xffffffff)),
    scaffoldBackgroundColor: Color(0xffffffff),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Color(0xffffffff),
      titleTextStyle: TextStyle(
        color: Color(0xff000000),
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      iconTheme: IconThemeData(
        color: Color(0xff000000),
      ),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        color: Color(0xff000000),
      ),
      bodyLarge: TextStyle(
        color: Color(0xff000000),
      ),
    ),
    iconTheme: IconThemeData(
      color: Color(0xff000000),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Color(0xff000000),
      unselectedItemColor: Color(0xffd6d6d6),
      backgroundColor: Color(0xffffffff),
    ),
    canvasColor: const Color(0xffffffff),
    hintColor: const Color(0xff000000),
    listTileTheme: ListTileThemeData(
      textColor: Color(0xff000000),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Color(0xff000000),
      ),
    ),
  );
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
