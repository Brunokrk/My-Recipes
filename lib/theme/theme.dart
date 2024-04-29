import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: const Color.fromRGBO(1, 29, 43, 1),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Color.fromRGBO(1, 29, 43, 1),
      titleTextStyle: TextStyle(color: Color.fromRGBO(255, 250, 221, 1)),
      actionsIconTheme: IconThemeData(color: Color.fromRGBO(255, 250, 221, 1)),
      iconTheme: IconThemeData(color: Color.fromRGBO(255, 250, 221, 1)),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Color.fromRGBO(255, 250, 221, 1)),
      bodyText2: TextStyle(color: Color.fromRGBO(255, 250, 221, 1)),
    ).apply(
      bodyColor: const Color.fromRGBO(255, 250, 221, 1),
      displayColor: const Color.fromRGBO(255, 250, 221, 1),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFDC6425),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFFDC6425),
        onPrimary: const Color.fromRGBO(255, 250, 221, 1),
      ),
    ),
  );
}
