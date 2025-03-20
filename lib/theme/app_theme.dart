import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[100],
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueAccent,
      elevation: 2,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontSize: 16), // ✅ Fix: Replacing bodyText2
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color.fromARGB(255, 243, 228, 88),
    cardColor: const Color.fromARGB(255, 199, 195, 195),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black87,
      elevation: 2,
    ),
    textTheme: TextTheme(
      bodyMedium:
          TextStyle(fontSize: 16, color: Colors.white), // ✅ Fix: Use bodyMedium
    ),
  );
}
