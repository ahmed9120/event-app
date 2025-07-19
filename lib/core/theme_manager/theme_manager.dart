import 'package:flutter/material.dart';

import 'color_pallete.dart';

abstract class ThemeMangaer{
  static ThemeData lightTheme= ThemeData(
    scaffoldBackgroundColor: ColorPallete.lightBackgroundColor,
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
    )
  );
  static ThemeData darkTheme= ThemeData(

  );
}