import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/layout/adaptive_layout.dart';
import 'package:flutter_task07_real_estate_app_beg/core/layout/responsive_layout.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/app_loader.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/login_view.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading || state is AuthSigningOut) {
          return const Scaffold(body: Center(child: AppLoader()));
        }

        if (state is AuthLoaded) {
          return ResponsiveLayout(role: state.role);
        }

        if (state is AuthInitial ||
            state is AuthSignedOut ||
            state is AuthSignOutError) {
          return const AdaptiveLayout(wideScreenView: LoginView());
        }

        if (state is AuthError) {
          return Scaffold(body: Center(child: Text(state.message)));
        }

        return const SizedBox.shrink();
      },
    );
  }
}
