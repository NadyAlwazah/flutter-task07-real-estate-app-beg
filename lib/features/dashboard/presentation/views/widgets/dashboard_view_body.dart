import 'package:flutter/cupertino.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_top_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_section.dart';

class DashboardViewBody extends StatelessWidget {
  const DashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SidebarSection(),

        SizedBox(width: 2),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DashboardTopBar(),
              SizedBox(height: 20),
              Padding(padding: EdgeInsets.all(24.0), child: DashboardHeader()),
            ],
          ),
        ),
      ],
    );
  }
}
