import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class RoleDropdown extends StatelessWidget {
  final String currentRole;
  final String email;
  final String uid;
  final Future<void> Function(
    String uid,
    String oldRole,
    String newRole,
    String email,
  )
  onUpdate;
  final VoidCallback onRefresh;

  const RoleDropdown({
    super.key,
    required this.currentRole,
    required this.email,
    required this.uid,
    required this.onUpdate,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              currentRole == "admin" ? Icons.shield : Icons.person,
              color: AppColors.primary,
              size: 20.r,
            ),
            const SizedBox(width: 6),
            DropdownButton<String>(
              value: currentRole,
              icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
                color: Colors.black,
              ),
              items: const [
                DropdownMenuItem(value: "user", child: Text("User")),
                DropdownMenuItem(value: "admin", child: Text("Admin")),
              ],
              onChanged: (value) async {
                if (value == currentRole) return;

                await onUpdate(uid, currentRole, value!, email);

                if (!context.mounted) return;

                onRefresh();
              },
            ),
          ],
        ),
      ),
    );
  }
}
