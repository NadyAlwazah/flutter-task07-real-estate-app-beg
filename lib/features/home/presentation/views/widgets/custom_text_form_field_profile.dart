import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class CustomTextFormFieldProfile extends StatelessWidget {
  const CustomTextFormFieldProfile({
    super.key,
    this.hintText,
    required this.textInputType,
    this.validator,
    this.controller,
  });
  final String? hintText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.check_rounded, color: AppColors.primary),
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xFF777A86)),
        filled: true,
        fillColor: const Color(0xFFF7F7F9),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(width: 1, color: Color(0xFFFBFBFC)),
    );
  }
}
