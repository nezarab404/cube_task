import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract final class AppThemes {
  static ThemeData get lightTheme => ThemeData(
        primarySwatch: AppColors.primary.toMaterialColor(),
        brightness: Brightness.light,
        fontFamily: GoogleFonts.cairo().fontFamily,
        textTheme: _textTheme,
      );

  static ThemeData get darkTheme => ThemeData(
        primarySwatch: AppColors.primary.toMaterialColor(),
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.cairo().fontFamily,
        textTheme: _darkTextTheme,
      );

  static TextTheme get _textTheme => TextTheme(
        displayLarge: TextStyle(
          fontSize: 38.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        displaySmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.black,
        ),
        titleLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.black,
        ),
        bodyLarge: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        labelSmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.primary,
        ),
      );

  static TextTheme get _darkTextTheme => TextTheme(
        displayLarge: TextStyle(
          fontSize: 38.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        displayMedium: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        displaySmall: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        titleLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        labelLarge: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        bodyLarge: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        bodySmall: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
        labelSmall: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 8.sp,
          fontWeight: FontWeight.normal,
          color: AppColors.primary,
        ),
      );

}
