import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/app/routes.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_button.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_snack_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/donot_have_an_account_widget.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/forget_password_text.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/login_form_fields.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_avatar.dart';
import 'package:go_router/go_router.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    final cubit = context.read<AuthCubit>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
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
                const SizedBox(height: 5),
                const ForgetPasswordText(),

                const SizedBox(height: 32),
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is AuthLoaded || current is AuthError,
                  listener: (context, state) {
                    if (state is AuthLoaded) {
                      if (state.role == "user") {
                        context.go(AppRouter.kUserHome);
                      } else if (state.role == "admins") {
                        context.go(AppRouter.kDashboard);
                      }
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(message: state.message, isError: true),
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AuthLoading || current is AuthError,
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CustomButton(isLoading: true);
                    }
                    return CustomButton(
                      text: "Sign In",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await cubit.loginWithEmailAndPassword(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 32),
                const DonotHaveAnAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
