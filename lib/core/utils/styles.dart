import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

abstract class Styles {
  static TextStyle titleHeader = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 17,
  );
  static const TextStyle authLink = TextStyle(
    fontWeight: FontWeight.w500,
    color: AppColors.primary,
  );

  static const TextStyle authAction = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.w600,
  );
}
