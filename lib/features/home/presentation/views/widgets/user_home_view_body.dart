import 'package:flutter/cupertino.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/property_grid_section.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/favority_properties.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/home_top_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/sidebar_user_section.dart';

class UserHomeViewBody extends StatefulWidget {
  const UserHomeViewBody({super.key});

  @override
  State<UserHomeViewBody> createState() => _UserHomeViewBodyState();
}

class _UserHomeViewBodyState extends State<UserHomeViewBody> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SidebarUserSection(
          onItemSelected: (index) {
            setState(() => selectedIndex = index);
          },
        ),
        const SizedBox(width: 2),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              const SizedBox(height: 20),
              Expanded(
                child: IndexedStack(
                  index: selectedIndex,
                  children: const [
                    PropertyGridSection(),

                    FavorityProperties(),

                    Center(child: Text("Profile")),

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
