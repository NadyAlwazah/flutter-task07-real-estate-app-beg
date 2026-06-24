import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/user_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/profile_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/assets.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final profileServices = ProfileServicesImp.instance;

    return FutureBuilder<UserModel>(
      future: profileServices.fetchUserData(),
      builder: (context, snapshot) {
        String fullName = "Loading...";

        if (snapshot.connectionState == ConnectionState.waiting) {
          fullName = "Loading...";
        } else if (snapshot.hasError) {
          fullName = "Error";
        } else if (snapshot.hasData) {
          fullName = snapshot.data!.fullName;
        }

        return Container(
          width: double.infinity,
          height: 60.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFEFEFE),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              SizedBox(
                width: .27.sw,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search anything...',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 254, 254),
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black87,
                ),
                onPressed: () {},
              ),

              SizedBox(width: 10.w),

              Row(
                children: [
                  Text(
                    fullName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CircleAvatar(
                    radius: 18.r,
                    child: SvgPicture.asset(AssetsData.accountAvatar),
                  ),
                  SizedBox(width: 8.w),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.black54),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
