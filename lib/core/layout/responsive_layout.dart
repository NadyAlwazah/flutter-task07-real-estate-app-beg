import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/layout/adaptive_layout.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/user_home_view.dart';

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({super.key, required this.role});

  final String role;

  @override
  Widget build(BuildContext context) {
    if (role == 'admin') {
      return const AdaptiveLayout(wideScreenView: DashboardView());
    }

    return const AdaptiveLayout(wideScreenView: UserHomeView());
  }
}
