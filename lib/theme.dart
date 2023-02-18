import 'package:flutter/material.dart';

class ThemeColors {
  final dark = ThemeData(
    primarySwatch: Colors.orange,
    scaffoldBackgroundColor: Color(0xff000000),
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
    )

  );

  final light = ThemeData(
    primarySwatch: Colors.orange,
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
      )
  );
}
