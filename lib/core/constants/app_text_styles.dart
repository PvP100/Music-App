import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTextStyles {
  static const fontFamily = "Roboto";

  static const TextStyle regular = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle medium = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle bold = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle hintText = TextStyle(
    color: AppColors.color999999,
    fontSize: 14,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );
}
