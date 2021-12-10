import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const TextStyle text = TextStyle(color: Colors.black54, fontSize: 12);

  static const TextStyle text_14 =
      TextStyle(color: AppColors.black, fontSize: 14);

  static const TextStyle light_14 =
      TextStyle(color: AppColors.light, fontSize: 14);

  static const TextStyle white_14 =
      TextStyle(color: AppColors.white, fontSize: 14);
  static const TextStyle white_12 =
      TextStyle(color: AppColors.white, fontSize: 12);
  static const TextStyle black54_16 =
      TextStyle(color: AppColors.black, fontSize: 16);

  static const TextStyle black_18 =
      TextStyle(color: AppColors.black, fontSize: 18);

  static const TextStyle black_20 =
      TextStyle(color: AppColors.black, fontSize: 20);

  static const TextStyle black_16 =
      TextStyle(color: AppColors.black, fontSize: 16);

  static const TextStyle black_14 =
      TextStyle(color: AppColors.black, fontSize: 14);

  static const TextStyle black_18_bold = TextStyle(
      color: AppColors.black, fontSize: 18, fontWeight: FontWeight.bold);

  static const TextStyle white_16_bold = TextStyle(
      color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold);

  static const TextStyle light_18 =
      TextStyle(color: AppColors.light, fontSize: 18);

  static TextStyle blue_14(bool isEnabled) {
    if (isEnabled) {
      return TextStyle(color: AppColors.primary, fontSize: 14);
    } else {
      return TextStyle(color: AppColors.primary[100], fontSize: 14);
    }
  }
}

extension TextStyleEtx on TextStyle {
  TextStyle get bold {
    return copyWith(fontWeight: FontWeight.bold);
  }

  TextStyle size(double size) {
    return copyWith(fontSize: size);
  }

  TextStyle color(Color color) {
    return copyWith(color: color);
  }
}
