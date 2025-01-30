
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Первые 2 разряда указывается непрозрачность(альфа), поэтому добавляем FF, чтобы
// была полная непрозрачность у цвета
const primaryColor = Color(0xFFFF8702);

final mainTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Color(0xFFFFFDFC),
  progressIndicatorTheme:ProgressIndicatorThemeData(
    color: primaryColor,
  ),

  textTheme: TextTheme(
    bodySmall: GoogleFonts.nunito(fontSize: 11, fontWeight: FontWeight.w400),
    bodyMedium: GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w400),
    bodyLarge: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.w800),
  )
);