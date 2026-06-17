import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';

class ForgetPasswordText extends StatelessWidget {
  final VoidCallback? onTap;

  const ForgetPasswordText({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.35.sw,
      child: Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: onTap,
          child: const Text("Forget Password?", style: Styles.authLink),
        ),
      ),
    );
  }
}
