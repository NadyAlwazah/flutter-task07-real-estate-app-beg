import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SidebarSectionTitle extends StatelessWidget {
  final String title;

  const SidebarSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
