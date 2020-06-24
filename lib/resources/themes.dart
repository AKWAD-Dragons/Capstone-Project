import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static final appTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    primaryColorDark: AppColors.primaryColor,
    accentColor: AppColors.accentColor,
    iconTheme: iconTheme,
    scaffoldBackgroundColor: AppColors.white,
    accentIconTheme: iconTheme,
    primaryIconTheme: iconTheme,
    hintColor: Colors.transparent,
    fontFamily: "Poppins",
    textTheme: TextTheme(
      headline: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold, color: AppColors.white),
      body2: TextStyle(fontSize: 14.0, color: AppColors.white),
    ),
  );

  static final iconTheme = IconThemeData(color: AppColors.primaryColor);
}
