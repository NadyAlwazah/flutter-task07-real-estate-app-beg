import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/assets.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_snack_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/auth/manager/auth_cubit/auth_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_item.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_menu_item.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/sidebar_section_title%20.dart';

class SidebarSection extends StatefulWidget {
  const SidebarSection({super.key, required this.onItemSelected});
  final ValueChanged<int> onItemSelected;
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
      width: 200.w,
      color: const Color(0xFFFEFEFE),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLogo(),

            const SizedBox(height: 20),

            const SidebarSectionTitle("Menu"),
            const SizedBox(height: 10),

            _buildMenuList(menuItems, 0),

            const SizedBox(height: 10),

            const SidebarSectionTitle("Others"),
            const SizedBox(height: 10),

            _buildMenuList(othersItems, menuItems.length),

            const Spacer(),

            BlocListener<AuthCubit, AuthState>(
              listenWhen: (previous, current) => current is AuthSignOutError,
              listener: (context, state) {
                if (state is AuthSignOutError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(message: state.message, isError: true),
                  );
                }
              },
              child: ListTile(
                leading: Icon(size: 20.r, Icons.logout, color: Colors.red),
                title: Text(
                  'Log Out',
                  style: Styles.textStyle12W600.copyWith(color: Colors.red),
                ),
                onTap: () async {
                  context.read<AuthCubit>().signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Image.asset(AssetsData.logo, width: 30.w, height: 30.h),
        const SizedBox(width: 8),
        Text(
          'PropWise',
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildMenuList(List<SidebarMenuItem> items, int offset) {
    return Column(
      children: List.generate(items.length, (index) {
        final item = items[index];
        final realIndex = offset + index;

        return SidebarItem(
          isActive: selectedIndex == realIndex,
          icon: item.icon,
          title: item.title,
          onTap: () => setState(() {
            selectedIndex = realIndex;
            widget.onItemSelected(realIndex);
          }),
        );
      }),
    );
  }
}
