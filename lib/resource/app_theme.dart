
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes{
  ThemeData theme;


  AppThemes(this.theme);

  factory AppThemes.base()=> AppThemes(
      ThemeData(
        appBarTheme: AppBarTheme(
          toolbarHeight: 48,
        ),
        primaryColor: AppColors.primary,
        brightness: Brightness.light,
        fontFamily: kIsWeb ? null : (Platform.isAndroid ? "font_default" : null),
      )
  );





}