import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/property_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/app_loader.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/property_card.dart';

class PropertyGridSection extends StatelessWidget {
  const PropertyGridSection({super.key});

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

              return PropertyCard(propertyModel: property);
            },
          );
        },
      ),
    );
  }
}
