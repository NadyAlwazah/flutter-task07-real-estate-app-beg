import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_button.dart';

import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/role_dropdown.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_avatar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_form_fields.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String selectedRole = "user";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const SignupAvatar(),

                const SizedBox(height: 20),
                const AuthHeader(
                  title: "Create Account",
                  subtitle: "Sign up to continue using the app",
                ),

                const SizedBox(height: 16),

                SignupFormFields(
                  fullNameController: fullNameController,
                  emailController: emailController,
                  passwordController: passwordController,
                ),

                const SizedBox(height: 12),

                RoleDropdown(
                  selectedRole: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),

                const SizedBox(height: 16),
                CustomButton(
                  text: "Sign Up",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
