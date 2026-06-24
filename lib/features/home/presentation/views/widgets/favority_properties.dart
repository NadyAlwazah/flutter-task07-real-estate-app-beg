import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/favorite_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/user_property_card.dart';

class FavorityProperties extends StatelessWidget {
  const FavorityProperties({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteServices = FavoriteServicesImp.instance;

    return StreamBuilder<List<PropertyModel>>(
      stream: favoriteServices.getFavoritePropertiesUserStream(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 15,
              color: AppColors.primary,
            ),
          );
        }

        final wishlist = snapshot.data!;

        if (wishlist.isEmpty) {
          return const Center(
            child: Text(
              "No favorite properties yet",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(20.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 4 : 2,
            crossAxisSpacing: 20.w,
            mainAxisSpacing: 20.h,
            childAspectRatio: 1.1,
          ),
          itemCount: wishlist.length,
          itemBuilder: (context, index) {
            final property = wishlist[index];
            return UserPropertyCard(
              propertyModel: property,
              forceFavorite: true,
            );
          },
        );
      },
    );
  }
}
