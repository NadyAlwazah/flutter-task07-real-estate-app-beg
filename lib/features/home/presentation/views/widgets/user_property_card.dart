import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/manager/property_favorite_cubit/property_favorite_cubit.dart';

class UserPropertyCard extends StatelessWidget {
  final PropertyModel propertyModel;
  final bool forceFavorite;
  final VoidCallback? onTap;
  const UserPropertyCard({
    super.key,
    required this.propertyModel,
    this.forceFavorite = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final propertyFavoriteCubit = PropertyFavoriteCubit();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: propertyModel.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(
                            color: AppColors.primary,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child:
                          BlocBuilder<
                            PropertyFavoriteCubit,
                            PropertyFavoriteState
                          >(
                            bloc: propertyFavoriteCubit,
                            buildWhen: (previous, current) =>
                                current is PropertyFavoriteLoading ||
                                current is PropertyFavoriteSuccess ||
                                current is PropertyFavoriteError,
                            builder: (context, state) {
                              if (state is PropertyFavoriteLoading) {
                                return const CupertinoActivityIndicator(
                                  color: Colors.red,
                                );
                              } else if (state is PropertyFavoriteSuccess) {
                                return state.isFavorite
                                    ? GestureDetector(
                                        onTap: () async =>
                                            await propertyFavoriteCubit
                                                .toggleFavorite(propertyModel),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                          size: 20.r,
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () async =>
                                            await propertyFavoriteCubit
                                                .toggleFavorite(propertyModel),
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: AppColors.primary,
                                          size: 20.r,
                                        ),
                                      );
                              }
                              return GestureDetector(
                                onTap: () async => await propertyFavoriteCubit
                                    .toggleFavorite(propertyModel),
                                child: forceFavorite
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20.r,
                                      )
                                    : propertyModel.isFavorite
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 20.r,
                                      )
                                    : Icon(
                                        Icons.favorite_border,
                                        color: AppColors.primary,
                                        size: 20.r,
                                      ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    propertyModel.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: 8.h),
                  Text(
                    "\$${propertyModel.price}",
                    style: Styles.textStyle13Bold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
