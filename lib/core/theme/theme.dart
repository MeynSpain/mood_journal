
import 'package:flutter/material.dart';

// Первые 2 разряда указывается непрозрачность(альфа), поэтому добавляем FF, чтобы
// была полная непрозрачность у цвета
const primaryColor = Color(0xFFFF8702);

final mainTheme =ThemeData(
  primaryColor: primaryColor,

  progressIndicatorTheme:ProgressIndicatorThemeData(
    color: primaryColor,
  ),
);