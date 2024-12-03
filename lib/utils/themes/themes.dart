import 'package:flutter/material.dart';

import '../resources.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    switchTheme: const SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(ColorResources.darkColor),
        trackOutlineWidth: WidgetStatePropertyAll(1),
        trackColor: WidgetStatePropertyAll(ColorResources.lightTextColor)),
    iconTheme: const IconThemeData(color: Colors.white),
    cardTheme: const CardTheme(color: ColorResources.cardColor),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor:
          Colors.white, // Set the background color of the date picker
    ),
    dialogBackgroundColor: ColorResources.appBarColor,
    dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
        contentTextStyle: TextStyle(color: Colors.white)),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Colors.white, // Border color when focused
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Colors.white, // Border color when enabled
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Colors.red, // Error border color
          width: 1,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.white, // Label text color
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: ColorResources.lightTextColor, // Hint text color
        fontStyle: FontStyle.italic,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    ),
    appBarTheme: const AppBarTheme(
      color: ColorResources.appBarColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorResources.appBarColor,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    switchTheme: const SwitchThemeData(
        thumbColor: WidgetStatePropertyAll(ColorResources.darkColor),
        trackOutlineWidth: WidgetStatePropertyAll(1),
        trackColor: WidgetStatePropertyAll(ColorResources.lightTextColor)),
    listTileTheme:
        const ListTileThemeData(textColor: ColorResources.lightTextColor),
    scaffoldBackgroundColor: ColorResources.appBarColor,
    iconTheme: const IconThemeData(color: Colors.white),
    cardTheme:
        CardTheme(color: ColorResources.darkAppBarColor.withOpacity(0.7)),
    datePickerTheme: const DatePickerThemeData(
      backgroundColor:
          Colors.black, // Set the background color of the date picker
    ),
    dialogBackgroundColor: ColorResources.appBarColor,
    dialogTheme: const DialogTheme(
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 15),
        contentTextStyle: TextStyle(color: Colors.white)),
    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Colors.white, // Border color when focused
          width: 1.0,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Colors.white, // Border color when enabled
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
        borderSide: const BorderSide(
          color: Colors.red, // Error border color
          width: 1,
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.white, // Label text color
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: Colors.white70, // Hint text color
        fontStyle: FontStyle.italic,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    ),
    appBarTheme: const AppBarTheme(
      color: ColorResources.darkAppBarColor,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: ColorResources.darkAppBarColor,
    ),
  );
}
