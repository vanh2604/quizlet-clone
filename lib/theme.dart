import 'package:flutter/material.dart';

var appTheme = ThemeData(
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyText1: TextStyle(fontSize: 18),
    bodyText2: TextStyle(fontSize: 16),
    button: TextStyle(
      letterSpacing: 0,
      fontWeight: FontWeight.bold,
    ),
    headline1: TextStyle(
      fontWeight: FontWeight.bold,
    ),
    subtitle1: TextStyle(
      color: Colors.grey,
    ),
  ),
  buttonTheme: const ButtonThemeData(),
  fontFamily: "GoogleSans",
  primarySwatch: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary:
          const Color.fromRGBO(66, 86, 255, 1), // background (button) color
      onPrimary: Colors.black, // foreground (text) color
    ),
  ),
);
