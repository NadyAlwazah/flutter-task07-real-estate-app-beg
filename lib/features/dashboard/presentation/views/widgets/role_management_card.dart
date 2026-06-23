import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
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
  final VoidCallback onRefresh;

  const RoleManagementCard({
    super.key,
    required this.user,
    required this.onUpdate,
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
                    user["email"],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Current Role: ${user["role"]}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),

            RoleDropdown(
              currentRole: user["role"],
              email: user["email"],
              uid: user["uid"],
              onUpdate: onUpdate,
              onRefresh: onRefresh,
            ),
          ],
        ),
      ),
    );
  }
}
