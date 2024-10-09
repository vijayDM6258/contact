import 'package:flutter/material.dart';

ThemeData light = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: Colors.red,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.grey),
      bodyLarge: TextStyle(color: Colors.grey, fontSize: 30),
    ),
    floatingActionButtonTheme:
        FloatingActionButtonThemeData(backgroundColor: Colors.red));

ThemeData dark = ThemeData.dark().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.yellow,
  ),
  appBarTheme: AppBarTheme(
    centerTitle: true,
    color: Colors.yellow,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white, fontSize: 30),
  ),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.white),
  scaffoldBackgroundColor: Colors.black,
);
