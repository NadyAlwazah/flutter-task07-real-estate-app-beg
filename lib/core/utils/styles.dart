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
  static TextStyle textStyle13Bold = TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: 13.sp,
  );
  static TextStyle textStyle14Grey = TextStyle(
    fontSize: 14.sp,
    color: Colors.grey[700],
  );
  static TextStyle textStyle12W600 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  );
  static TextStyle textStyle24Bold = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
  );
  static TextStyle textStyle20Bold = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  static TextStyle textStyle16Grey = TextStyle(
    fontSize: 16.sp,
    color: Colors.grey,
  );
  static TextStyle textStyle22Bold = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: const Color(0xFF333333),
  );
}
