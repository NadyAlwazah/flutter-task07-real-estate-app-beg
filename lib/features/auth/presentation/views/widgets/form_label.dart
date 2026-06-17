import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class FormLabel extends StatelessWidget {
  final String text;

  const FormLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
