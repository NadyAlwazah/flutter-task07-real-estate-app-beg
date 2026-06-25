import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';
import 'role_dropdown.dart';

class RoleManagementCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final Future<void> Function(
    String uid,
    String oldRole,
    String newRole,
    String email,
  )
  onUpdate;

  final Future<void> Function(String uid) onDelete;
  final VoidCallback onRefresh;

  const RoleManagementCard({
    super.key,
    required this.user,
    required this.onUpdate,
    required this.onDelete,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.primary.withOpacity(0.15),
              child: Text(
                user["email"][0].toUpperCase(),
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user["fullName"].toString(),
                    style: Styles.textStyle12W600,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    user["email"],
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),

            //! Dropdown
            RoleDropdown(
              currentRole: user["role"],
              email: user["email"],
              uid: user["uid"],
              onUpdate: onUpdate,
              onRefresh: onRefresh,
            ),

            SizedBox(width: 10.w),

            IconButton(
              icon: Icon(Icons.delete, color: Colors.red, size: 20.sp),
              onPressed: () {
                _showDeleteDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Delete User"),
          content: Text("Are you sure you want to delete ${user["fullName"]}?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
              onPressed: () async {
                Navigator.pop(context);
                await onDelete(user["uid"]);
                onRefresh();
              },
            ),
          ],
        );
      },
    );
  }
}
