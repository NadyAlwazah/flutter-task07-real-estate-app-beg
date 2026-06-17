import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class RoleDropdown extends StatelessWidget {
  final String selectedRole;
  final Function(String?) onChanged;

  const RoleDropdown({
    super.key,
    required this.selectedRole,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: 0.35.sw,
      initialSelection: selectedRole,
      label: const Text(
        "Select Role",
        style: TextStyle(color: AppColors.primary),
      ),
      onSelected: onChanged,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      dropdownMenuEntries: const [
        DropdownMenuEntry(value: "user", label: "User"),
        DropdownMenuEntry(value: "admin", label: "Admin"),
      ],
    );
  }
}
