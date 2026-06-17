import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 37.5.r,
      backgroundColor: Colors.white,
      child: Icon(Icons.person, size: 40.sp, color: AppColors.primary),
    );
  }
}
