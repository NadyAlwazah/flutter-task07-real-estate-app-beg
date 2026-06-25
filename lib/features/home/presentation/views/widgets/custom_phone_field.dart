import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends StatelessWidget {
  final Function(String)? onChanged;
  final String initialCountryCode;
  final TextEditingController? controller;
  final String? Function(PhoneNumber?)? validator;

  const CustomPhoneField({
    super.key,
    this.onChanged,
    this.initialCountryCode = 'SY',
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.check_rounded, color: AppColors.primary),
        hintText: 'Phone Number',
        hintStyle: const TextStyle(color: Color(0xFF777A86)),
        filled: true,
        fillColor: const Color(0xFFF7F7F9),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),

      showCountryFlag: false,
      dropdownIconPosition: IconPosition.trailing,
      initialCountryCode: initialCountryCode,

      onChanged: (phone) {
        if (onChanged != null) {
          onChanged!(phone.completeNumber);
        }
      },
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(width: 1, color: Color(0xFFFBFBFC)),
    );
  }
}
