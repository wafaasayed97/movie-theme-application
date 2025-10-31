import 'package:flutter/material.dart';
import '/core/theme/dark_colors.dart';

final ColorScheme darkColorScheme = ColorScheme(
  primary: AppDarkColors.primary,
  secondary: Colors.green,
  surface: Color(0xFF121212),
  onSurface: Colors.white,
  surfaceContainerHighest: Color(0xFF1E1E1E),
  error: Color(0xFFEC221F),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onError: Colors.white,
  brightness: Brightness.dark,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: darkColorScheme,
  useMaterial3: true,
  hintColor: AppDarkColors.hint,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: AppDarkColors.hint),
    fillColor: AppDarkColors.formfiledFillColor,
  ),
  cardColor: Color(0xFF1E1E1E),
  dividerColor: Color(0xFF4A4A4A),
);