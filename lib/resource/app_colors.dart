import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color EDF0F5 = Color(0xFFEDF0F5);

  static const Color light = Color(0xFF999999);

  static const MaterialColor primary = MaterialColor(
    0xFF2879FF,
    <int, Color>{
      100: Color(0xFFB0CCFB),
      300: Color(0xFF639EFF),
      500: Color(0xFF2879FF),
      900: Color(0xFF0060FF),
    },
  );

  static const Color red = Color(0xFFFF603F);

  static const Color white = Color(0xFFFFFFFF);

  static const Color bg_default = Color(0xFFF4F6F9);


  static const MaterialColor black = MaterialColor(
    0xFF333333,
    <int, Color>{
      100: Color(0xFFE6E6E6),
      300: Color(0xFF999999),
      500: Color(0xFF666666),
      900: Color(0xFF333333),
    },
  );

}
