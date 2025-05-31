import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(surface: Color(0xff0D0D0D)),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    background: Color(0xff0D0D0D),
    onBackground: Color(0xff1A1A1A),
    primary: Color(0xffFFD300),
    onPrimary: Color(0xffFFB300),
    secondary: Color(0xff7D7D7D),
    surface: Color(0xff0D0D0D),
    onSurface: Colors.white,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
  ),
  useMaterial3: false,
);
