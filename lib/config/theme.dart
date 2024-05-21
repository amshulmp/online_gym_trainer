import 'package:flutter/material.dart';

ThemeData gymTheme = ThemeData(
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: const Color(0xFFFFA500),
    secondary: const Color(0xFF3498DB), 
    onPrimary: Colors.black,
    onSurfaceVariant: Colors.orange.shade100, 
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFFFA500),
  ),
);
