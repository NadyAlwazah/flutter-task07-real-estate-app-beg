import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_menu_item.dart';

class SidebarSection extends StatefulWidget {
  const SidebarSection({super.key});

  @override
  State<SidebarSection> createState() => _SidebarSectionState();
}

class _SidebarSectionState extends State<SidebarSection> {
  int selectedIndex = 0;

  final List<SidebarMenuItem> menuItems = [
    SidebarMenuItem('Dashboard', Icons.grid_view_outlined),
    SidebarMenuItem('Properties', Icons.home_work_outlined),
    SidebarMenuItem('Agents', Icons.people_alt_outlined),
    SidebarMenuItem('Analytics', Icons.show_chart_outlined),
    SidebarMenuItem('Messages', Icons.chat_bubble_outline),
    SidebarMenuItem('Wishlist', Icons.favorite_border),
    SidebarMenuItem('Transactions', Icons.receipt_long_outlined),
  ];

  final List<SidebarMenuItem> othersItems = [
    SidebarMenuItem('Help Center', Icons.info_outline),
    SidebarMenuItem('Settings', Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: const Color(0xFFFEFEFE),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildLogo(), const SizedBox(height: 20)],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Image.asset(
          "assets/icons/Copilot_20260619_120224.png",
          width: 30.w,
          height: 30.h,
        ),
        const SizedBox(width: 8),
        Text(
          'PropWise',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
