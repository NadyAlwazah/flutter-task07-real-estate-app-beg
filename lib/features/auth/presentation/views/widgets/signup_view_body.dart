import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/app/routes.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_button.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_snack_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/manager/auth_cubit/auth_cubit.dart';

import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/have_an_account_widget.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/role_dropdown.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_avatar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/widgets/signup_form_fields.dart';
import 'package:go_router/go_router.dart';

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
                  title: "Get Started",
                  subtitle: "Create an account to continue",
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
                BlocConsumer<AuthCubit, AuthState>(
                  bloc: cubit,
                  listenWhen: (previous, current) =>
                      current is AuthLoaded || current is AuthError,

                  listener: (context, state) {
                    if (state is AuthLoaded) {
                      if (selectedRole == "user") {
                        context.go(AppRouter.kUserHome);
                      } else if (selectedRole == "admins") {
                        context.go(AppRouter.kDashboard);
                      }
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        CustomSnackBar(message: state.message, isError: true),
                      );
                    }
                  },
                  buildWhen: (previous, current) =>
                      current is AuthLoading ||
                      current is AuthError ||
                      current is AuthLoaded,
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CustomButton(isLoading: true);
                    }
                    return CustomButton(
                      text: "Sign Up",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await cubit.registerWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                            fullName: fullNameController.text,
                            role: selectedRole,
                          );
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 32),
                const HaveAnAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
