import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    primaryColor: Colors.cyan[400],
    useMaterial3: true,
    brightness: Brightness.dark,
    // textTheme: const TextTheme(
    //   headlineLarge: TextStyle(
    //     fontSize: 64.0,
    //     fontWeight: FontWeight.bold,
    //   ),
    //   titleMedium: TextStyle(
    //     fontSize: 24.0,
    //     fontStyle: FontStyle.italic,
    //   ),
    //   bodySmall: TextStyle(fontSize: 18.0),
    // ),
  );

  static BoxDecoration blueGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: const <double>[0.1, 0.3, 0.5, 0.7, 0.9],
      colors: <Color>[
        Colors.blue[300]!,
        Colors.blue[400]!,
        Colors.blue[500]!,
        Colors.blue[600]!,
        Colors.blue[700]!,
      ],
    ),
  );

  // static TextStyle productDetailNameStyle = const TextStyle(
  //   fontSize: 28.0,
  //   fontStyle: FontStyle.italic,
  // );
}
