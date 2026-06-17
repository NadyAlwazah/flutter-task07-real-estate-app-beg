import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/donot_have_an_account_widget.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_avatar.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40),
              AppAvatar(),

              SizedBox(height: 20),
              AuthHeader(
                title: "Login Account",
                subtitle: "Login to continue using the app",
              ),

              SizedBox(height: 32),
              DonotHaveAnAccountWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
