import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/validators.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/form_label.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/custom_phone_field.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/custom_text_form_field_profile.dart';

class EditProfileFormFields extends StatelessWidget {
  const EditProfileFormFields({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneNumberController,
    required this.emailController,
    required this.locationController,
  });
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneNumberController;

  final TextEditingController locationController;
  final TextEditingController emailController;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FormLabel(text: "First Name"),
        const SizedBox(height: 8),
        CustomTextFormFieldProfile(
          controller: firstNameController,
          textInputType: TextInputType.text,
          validator: Validators.validateFullName,
          hintText: "Enter your first name",
        ),
        const SizedBox(height: 16),

        const FormLabel(text: "Last Name"),
        const SizedBox(height: 8),
        CustomTextFormFieldProfile(
          controller: lastNameController,
          textInputType: TextInputType.text,
          validator: Validators.validateFullName,
          hintText: "Enter your last name",
        ),
        const SizedBox(height: 16),

        const SizedBox(height: 16),
        const FormLabel(text: "Email"),
        const SizedBox(height: 8),
        CustomTextFormFieldProfile(
          controller: emailController,
          textInputType: TextInputType.emailAddress,

          hintText: "Enter your email",
        ),
        const SizedBox(height: 16),
        const FormLabel(text: "Location"),
        const SizedBox(height: 8),
        CustomTextFormFieldProfile(
          controller: locationController,
          textInputType: TextInputType.text,

          hintText: "Enter your location",
        ),
        const SizedBox(height: 16),

        const FormLabel(text: "Mobile Number"),
        const SizedBox(height: 8),
        CustomPhoneField(controller: phoneNumberController),
      ],
    );
  }
}
