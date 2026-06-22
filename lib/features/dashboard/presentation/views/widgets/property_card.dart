import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PropertyCard extends StatelessWidget {
  final String title;
  final String location;
  final int beds;
  final int baths;
  final String area;
  final String price;
  final String image;

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const PropertyCard({
    super.key,
    required this.title,
    required this.location,
    required this.beds,
    required this.baths,
    required this.area,
    required this.price,
    required this.image,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
                    child: Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  if (onEdit != null)
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.1),
                        child: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: onEdit,
                          tooltip: "Edit",
                        ),
                      ),
                    ),

                  if (onDelete != null)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.1),
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: onDelete,
                          tooltip: "Delete",
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  location,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.bed_rounded, size: 16.sp, color: Colors.black87),
                    SizedBox(width: 4.w),
                    Text('$beds', style: TextStyle(fontSize: 11.sp)),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.bathtub_outlined,
                      size: 16.sp,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 4.w),
                    Text('$baths', style: TextStyle(fontSize: 11.sp)),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.fullscreen_rounded,
                      size: 16.sp,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 4.w),
                    Text(area, style: TextStyle(fontSize: 11.sp)),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        color: const Color(0xFF1B4ED8),
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.favorite_border),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
