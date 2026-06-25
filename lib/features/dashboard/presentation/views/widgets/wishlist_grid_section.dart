import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/favorite_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/app_loader.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/property_card.dart';

class WishlistGridSection extends StatelessWidget {
  const WishlistGridSection({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteServices = FavoriteServicesImp.instance;

    return StreamBuilder<List<PropertyModel>>(
      stream: favoriteServices.getFavoritePropertiesAdminStream(),

      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: AppLoader());
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
            childAspectRatio: 0.80,
          ),
          itemCount: wishlist.length,
          itemBuilder: (context, index) {
            final property = wishlist[index];
            return PropertyCard(propertyModel: property, forceFavorite: true);
          },
        );
      },
    );
  }
}
