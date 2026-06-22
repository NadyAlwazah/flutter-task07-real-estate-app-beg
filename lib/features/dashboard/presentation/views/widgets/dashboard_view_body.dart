import 'package:flutter/cupertino.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_header.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_top_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/property_grid_section.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/property_management_grid_section.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_section.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key, required this.onIndexChanged});
  final ValueChanged<int> onIndexChanged;
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
            widget.onIndexChanged(index);
          },
        ),

        const SizedBox(width: 2),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardTopBar(),
              const SizedBox(height: 20),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: const [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(24.0),
                          child: DashboardHeader(),
                        ),
                        Expanded(child: PropertyGridSection()),
                      ],
                    ),

                    // Center(child: Text("Properties Page")),
                    PropertyManagementGridSection(),

                    Center(child: Text("Agents Page")),

                    Center(child: Text("Analytics Page")),

                    Center(child: Text("Messages Page")),

                    Center(child: Text("Wishlist Page")),

                    Center(child: Text("Transactions Page")),

                    Center(child: Text("Help Center")),

                    Center(child: Text("Settings")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
