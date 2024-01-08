import 'package:flutter/material.dart';

const colorList = <Color>[
  Colors.blue,
  Colors.teal,
  Colors.green,
  Color.fromARGB(255, 255, 109, 99),
  Colors.purple,
  Colors.deepPurple,
  Colors.orange,
  Colors.pink
];

class AppTheme {
  final int selectedColor;
  final bool isDark;

  AppTheme({this.selectedColor = 0, this.isDark = false})
      : assert(selectedColor >= 0, 'El color no puede ser menor que 0'),
        assert(selectedColor < colorList.length, 'El colorlist no puede ser mas que ${colorList.length}');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorScheme: isDark ? ColorScheme.dark(primary: colorList[ selectedColor ]) : const ColorScheme.light(primary: Color.fromARGB(255, 233, 90, 80)),
    // colorScheme: const ColorScheme(
    //   brightness: Brightness.dark, 
    //   primary: Colors.red, 
    //   onPrimary: const Color.fromARGB(255, 255, 210, 206), 
    //   secondary: Colors.blue, 
    //   onSecondary: const Color.fromARGB(255, 179, 221, 255), 
    //   error: Colors.red, 
    //   onError: const Color.fromARGB(255, 152, 131, 129), 
    //   background: Colors.white, 
    //   onBackground: const Color.fromARGB(255, 236, 250, 252), 
    //   surface: Colors.white, 
    //   onSurface: Colors.black
    // ),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
    ),
  );
}
