import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/edit_profile_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/profile_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/assets.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_button.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_snack_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/edit_profile_form_fields.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key, required this.onSaved});
  final VoidCallback onSaved;
  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final editProfileServices = EditProfileServicesImp.instance;
  final profileServices = ProfileServicesImp.instance;

  Future<void> saveProfile() async {
    if (_formKey.currentState!.validate()) {
      await editProfileServices.updateUserData(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        phoneNumber: phoneNumberController.text.trim(),
        email: emailController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(CustomSnackBar(message: "Updated successfully"));
      widget.onSaved();
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16.0),
      child: SingleChildScrollView(
        child: FutureBuilder(
          future: profileServices.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CupertinoActivityIndicator(
                  radius: 15,
                  color: AppColors.primary,
                ),
              );
            }

            if (!snapshot.hasData) {
              return const Text("No user data found");
            }

            final user = snapshot.data!;

            firstNameController.text = user.firstName ?? '';
            lastNameController.text = user.lastName ?? '';
            phoneNumberController.text = user.phoneNumber ?? '';
            emailController.text = user.email;

            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),
                  CircleAvatar(
                    radius: 45.r,
                    child: SvgPicture.asset(
                      AssetsData.accountAvatar,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 32),
                  EditProfileFormFields(
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,

                    phoneNumberController: phoneNumberController,
                    emailController: emailController,
                  ),
                  const SizedBox(height: 24),

                  CustomButton(text: "Save Changes", onPressed: saveProfile),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
