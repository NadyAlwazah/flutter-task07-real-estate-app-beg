import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/login_view.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/presentation/views/signup_view.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/user_home_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String kDashboard = '/dashboard';
  static const String kUserHome = '/user_home';
  static const String kSignup = '/signup';
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginView()),
      GoRoute(path: kSignup, builder: (context, state) => const SignupView()),
      GoRoute(
        path: kDashboard,
        builder: (context, state) => const DashboardView(),
      ),
      GoRoute(
        path: kUserHome,
        builder: (context, state) => const UserHomeView(),
      ),
    ],
  );
}
