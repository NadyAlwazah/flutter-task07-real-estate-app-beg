import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE8E8E8),
      body: DashboardViewBody(),
    );
  }
}
