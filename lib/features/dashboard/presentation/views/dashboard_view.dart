import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/add_property_bottom_sheet.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/dashboard_view_body.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  void _showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: const AddPropertyBottomSheet(),
        );
      },
    );
  }

  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E8E8),
      body: DashboardViewBody(
        onIndexChanged: (index) {
          setState(() => selectedIndex = index);
        },
      ),
      floatingActionButton: selectedIndex == 1
          ? FloatingActionButton(
              onPressed: _showAddBottomSheet,
              backgroundColor: Colors.purple,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }
}
