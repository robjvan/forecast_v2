/// Global App theme
/// Holds colors and styles

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    primaryColor: Colors.green,
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
}

class AppStyles {
  static const TextStyle drawerHeaderTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'Raleway',
  );
  static const TextStyle settingsButtonStyle = TextStyle(
    fontSize: 18,
    fontFamily: 'CarroisSC',
  );
  static const TextStyle cardHeaderStyle = TextStyle(
    fontSize: 14,
    // fontWeight: FontWeight.bold,
    fontFamily: 'Montserrat',
  );
  static const TextStyle cardBodyStyle = TextStyle(
    fontSize: 18,
  );
}

class AppColors {
  static const Color textColorLightMode = darkGrey;
  static const Color textColorDarkMode = white;
  static const Color bgColorLightMode = white;
  static const Color bgColorDarkMode = darkGrey;

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color green = Color(0xFF00FF00);
  static const Color blue = Color(0xFF0000FF);
  static const Color red = Color(0xFFFF0000);
  static const Color grey = Color(0xFF808080);
  static const Color lightGrey = Color(0xFFDDDDDD);
  static const Color locationTileDarkGrey = Color(0xFF303030);
  static const Color darkGrey = Color(0xFF202020);
}

class AppFonts {
  static const String carroisSC = 'CarroisSC';
  static const String montserrat = 'Montserrat';
}
