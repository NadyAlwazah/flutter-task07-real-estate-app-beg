import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/validators.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/form_label.dart';

class SignupFormFields extends StatelessWidget {
  const SignupFormFields({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
  });
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: "Full Name"),
        CustomTextFormField(
          controller: fullNameController,
          hintText: "Enter your full name",
          textInputType: TextInputType.text,

          prefixIcon: const Icon(Icons.person, color: AppColors.primary),
          validator: Validators.validateFullName,
        ),

        const SizedBox(height: 8),

        const FormLabel(text: "Email Address"),
        CustomTextFormField(
          controller: emailController,
          hintText: "name@example.com",
          textInputType: TextInputType.emailAddress,
          prefixIcon: const Icon(
            Icons.email_outlined,
            color: AppColors.primary,
          ),
          validator: Validators.validateEmail,
        ),

        const SizedBox(height: 8),

        const FormLabel(text: "Password"),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Min. 8 characters",
          textInputType: TextInputType.text,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock, color: AppColors.primary),
          validator: Validators.validatePassword,
        ),
      ],
    );
  }
}
