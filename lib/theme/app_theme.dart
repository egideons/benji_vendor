import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static CupertinoThemeData iOSLightTheme = const CupertinoThemeData(
    applyThemeToAll: true,
    textTheme: CupertinoTextThemeData(),
    brightness: Brightness.light,
  );
  static CupertinoThemeData iOSDarkTheme = const CupertinoThemeData(
    textTheme: CupertinoTextThemeData(),
    applyThemeToAll: true,
    brightness: Brightness.dark,
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: GoogleFonts.montserratTextTheme(),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.montserratTextTheme(),
  );
}
