import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbl/app/view/styles/app_colors.dart';

class AppTheme {
  static const AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: Color.fromRGBO(249, 249, 249, 0.94),
    centerTitle: true,  
    titleTextStyle: TextStyle(
      color: AppColors.black,
      fontSize: 17,
      fontWeight: FontWeight.w500,
    ),
  );

  static ThemeData themeData = ThemeData(
      bottomSheetTheme:
      const BottomSheetThemeData(
        backgroundColor: AppColors.white,
        showDragHandle: true,
        modalBackgroundColor: AppColors.white,
          surfaceTintColor: Colors.white,
      ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor:AppColors.white ,
    ),
    canvasColor: Colors.white,
    appBarTheme: appBarTheme,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryColor,
        primary:AppColors.primaryColor,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    useMaterial3: true,
    primarySwatch: const MaterialColor(
      0xffDC1250,
      AppColors.colorScratch,
    ),
  );
}
