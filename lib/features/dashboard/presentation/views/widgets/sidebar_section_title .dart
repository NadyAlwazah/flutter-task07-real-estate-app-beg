import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';

class SidebarSectionTitle extends StatelessWidget {
  final String title;

  const SidebarSectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Styles.textStyle14Grey.copyWith(
        color: Colors.grey[600],
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
