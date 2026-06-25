import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/property_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/app_loader.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/update_property_bottom_sheet.dart';
import 'property_card.dart';

class PropertyManagementGridSection extends StatefulWidget {
  const PropertyManagementGridSection({super.key});

  @override
  State<PropertyManagementGridSection> createState() =>
      _PropertyManagementGridSectionState();
}

class _PropertyManagementGridSectionState
    extends State<PropertyManagementGridSection> {
  void _showAddBottomSheet(PropertyModel propertyModel) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: UpdatePropertyBottomSheet(property: propertyModel),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final propertyServices = PropertyServicesImpl.instance;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: StreamBuilder<List<PropertyModel>>(
        stream: propertyServices.getPropertiesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: AppLoader());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No properties found"));
          }

          final properties = snapshot.data!;

          return GridView.builder(
            itemCount: properties.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 4 : 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              childAspectRatio: 0.80,
            ),
            itemBuilder: (context, index) {
              final property = properties[index];

              return PropertyCard(
                propertyModel: property,
                //!
                onEdit: () {
                  _showAddBottomSheet(property);
                },
                onDelete: () {
                  propertyServices.removeProperty(property.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
