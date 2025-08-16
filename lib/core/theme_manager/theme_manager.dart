import 'package:flutter/material.dart';

import 'color_pallete.dart';

abstract class ThemeManager{
  static ThemeData lightTheme= ThemeData(
    primaryColor: ColorPallete.primaryColor,
    scaffoldBackgroundColor: ColorPallete.lightBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorPallete.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedIconTheme : IconThemeData(
        color: Colors.white
    ),
      selectedLabelStyle: TextStyle(
        fontSize: 12,
        fontFamily: "Inter",
        fontWeight: FontWeight.w700,
        color: Colors.white
      ),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color:ColorPallete.appbarTitleColor,
      )
    ),
    textTheme: TextTheme(
      headlineSmall: TextStyle(
          color: ColorPallete.white,
          fontWeight: FontWeight.w700,
          fontSize: 24,
          fontFamily: "Inter"
      ),
      bodyLarge: TextStyle(
        color: ColorPallete.white,
        fontWeight: FontWeight.w500,
        fontSize: 20,
          fontFamily: "Inter"
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: "Inter"
      ),
      bodySmall: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          fontFamily: "Inter"
      ),
    )
  );
  static ThemeData darkTheme= ThemeData(
      primaryColor: ColorPallete.primaryColor,
      scaffoldBackgroundColor: ColorPallete.darkBackgroundColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorPallete.darkBackgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme : IconThemeData(
            color: ColorPallete.darkThemeHomeTextColor,
        ),
        selectedLabelStyle: TextStyle(
            fontSize: 12,
            fontFamily: "Inter",
            fontWeight: FontWeight.w700,
            color: Colors.white
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: ColorPallete.darkThemeHomeTextColor,
          ),
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color:ColorPallete.appbarTitleColor,
          )
      ),
      textTheme: TextTheme(
        headlineSmall: TextStyle(
            color: ColorPallete.white,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            fontFamily: "Inter"
        ),
        bodyLarge: TextStyle(
            color: ColorPallete.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
            fontFamily: "Inter"
        ),
        bodyMedium: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: "Inter"
        ),
        bodySmall: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
            fontFamily: "Inter"
        ),
      )
  );
}