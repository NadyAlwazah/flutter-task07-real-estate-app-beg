import 'package:flutter/cupertino.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_top_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/property_grid_section.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_section.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SidebarSection(
          onItemSelected: (index) {
            setState(() => selectedIndex = index);
          },
        ),

        const SizedBox(width: 2),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardTopBar(),
              const SizedBox(height: 20),
              if (selectedIndex != 1) ...[
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: DashboardHeader(),
                ),
                const Expanded(child: PropertyGridSection()),
              ] else ...[
                const Expanded(child: Center(child: Text("Properties Page"))),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
