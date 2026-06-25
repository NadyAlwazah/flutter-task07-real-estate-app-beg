import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/user_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/profile_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/assets.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';

class UserProfileViewBody extends StatelessWidget {
  const UserProfileViewBody({super.key, required this.onEditProfile});
  final VoidCallback onEditProfile;
  @override
  Widget build(BuildContext context) {
    final profileServices = ProfileServicesImp.instance;

    return FutureBuilder<UserModel>(
      future: profileServices.fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 15,
              color: AppColors.primary,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }

        if (!snapshot.hasData) {
          return const Center(child: Text("No user data found"));
        }

        final user = snapshot.data!;
        final name = user.fullName;
        final email = user.email;
        final location = user.location ?? "Not found";
        final phone = user.phoneNumber ?? "Not found";

        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45.r,
                child: SvgPicture.asset(
                  AssetsData.accountAvatar,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 20.h),

              Text(
                name,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 10.h),

              Text(
                email,
                style: Styles.textStyle14Grey.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 10.h),

              if (phone.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone, color: AppColors.primary, size: 19.r),

                    SizedBox(width: 6.w),
                    Text(phone, style: Styles.textStyle14Grey),
                  ],
                ),
              SizedBox(height: 10.h),

              if (location.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.primary,
                      size: 19.r,
                    ),

                    SizedBox(width: 6.w),
                    Text(location, style: Styles.textStyle14Grey),
                  ],
                ),

              SizedBox(height: 30.h),

              _settingsCard(
                icon: Icons.edit,
                title: "Edit Profile",
                color: AppColors.primary,
                onTap: onEditProfile,
              ),

              _settingsCard(
                icon: Icons.lock,
                title: "Change Password",
                color: AppColors.primary,
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _settingsCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          title,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
