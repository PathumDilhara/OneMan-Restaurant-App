import 'package:flutter/material.dart';
import 'package:oneman/core/utils/colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.light,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
      bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
      labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    ),
    scaffoldBackgroundColor: AppColors.primScaffoldBg,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primScaffoldBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: 80,
      iconTheme: IconThemeData(color: AppColors.primRed3)
    ),
  );
}
