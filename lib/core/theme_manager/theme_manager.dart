import 'package:flutter/material.dart';

import 'color_pallete.dart';

abstract class ThemeMangaer{
  static ThemeData lightTheme= ThemeData(
    scaffoldBackgroundColor: Colors.white,
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