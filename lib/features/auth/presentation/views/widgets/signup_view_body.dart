import 'package:flutter/material.dart';

import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_avatar.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              SignupAvatar(),

              SizedBox(height: 20),
              AuthHeader(
                title: "Create Account",
                subtitle: "Sign up to continue using the app",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
