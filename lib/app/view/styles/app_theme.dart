import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mbl/app/view/styles/app_colors.dart';
import 'package:mbl/core/constants/fonts.dart';



class AppTheme {
  static const AppBarTheme appBarTheme = AppBarTheme(
   // backgroundColor: Color.fromRGBO(249, 249, 249, 0.94),
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
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      accentColor: AppColors.textfieldPlaceColor,
    ),
    textTheme: GoogleFonts.ubuntuTextTheme(),
    primarySwatch: const MaterialColor(
      0xffDC1250,
      AppColors.colorScratch,
    ),
  );
}


class HalamedTheme with ChangeNotifier {
  static bool _isDarkTheme = false;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
  // 1
  static TextTheme lightTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displayLarge: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  );

  // 2
  static TextTheme darkTextTheme = const TextTheme(
    bodyLarge: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 21,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: AppFonts.inter,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  );

  // 3
  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateColor.resolveWith(
              (states) {
            return Colors.white;
          },
        ),
      ),
      appBarTheme: const AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: lightTextTheme,
      dialogTheme: const DialogTheme(
        backgroundColor: AppColors.white,
        surfaceTintColor:AppColors.white ,
      ),
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
      sliderTheme: SliderThemeData(
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        trackHeight: 4.0,
        thumbColor: AppColors.primaryColor,
        overlayColor: AppColors.primaryColor.withOpacity(0.2),
        overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
        rangeTrackShape: RoundedRectRangeSliderTrackShape(),
      ),

      canvasColor: Colors.white,

      scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.primaryColor,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: AppColors.textfieldPlaceColor,
      ),
    );
  }

  // 4
  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),
      textTheme: darkTextTheme,
    );
  }
}