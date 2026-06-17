import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/donot_have_an_account_widget.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/login_form_fields.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_avatar.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const AppAvatar(),

              const SizedBox(height: 20),
              const AuthHeader(
                title: "Login Account",
                subtitle: "Login to continue using the app",
              ),
              const SizedBox(height: 16),
              LoginFormFields(
                emailController: emailController,
                passwordController: passwordController,
              ),

              const SizedBox(height: 32),
              const DonotHaveAnAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
