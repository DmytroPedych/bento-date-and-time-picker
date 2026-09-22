import 'package:flutter/material.dart';

ThemeData get demoTheme {
  final ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF3D405B),
    onPrimary: Colors.white,
    secondary: Color(0xFF3D405B),
    onSecondary: Colors.white,
    error: Color(0xFFEB3A65),
    onError: Colors.white,
    surface: Color(0xFFF4F3F3),
    onSurface: Color(0xFF1A1A1A),
    surfaceContainer: Color(0xFFFFFFFF),
    outline: Color(0xFFE6E6E6),
  );
  return ThemeData(colorScheme: colorScheme, textTheme: TextTheme(), extensions: {});
}
