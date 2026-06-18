import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/login_view.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/user_home_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(radius: 15, color: Colors.red),
            ),
          );
        }

        if (state is AuthLoaded) {
          if (state.role == 'user') {
            return const UserHomeView();
          }

          return const DashboardView();
        }

        if (state is AuthInitial) {
          return const LoginView();
        }

        if (state is AuthError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
