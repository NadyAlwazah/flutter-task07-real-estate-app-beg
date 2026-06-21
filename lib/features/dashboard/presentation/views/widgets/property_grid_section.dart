import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'property_card.dart';

class PropertyGridSection extends StatelessWidget {
  const PropertyGridSection({super.key});

  final List<PropertyCard> propertyCards = const [
    PropertyCard(
      title: 'Modern Minimalist',
      location: 'Sapphire Street, USA',
      beds: 2,
      baths: 2,
      area: '2,500 sqft',
      price: '\$1,500,000',
      image: 'assets/images/home_3.png',
    ),
    PropertyCard(
      title: 'Mid-Century Modern',
      location: 'Sapphire Street, USA',
      beds: 2,
      baths: 2,
      area: '1,200 sqft',
      price: '\$1,200,000',
      image: 'assets/images/home_3.png',
    ),
    PropertyCard(
      title: 'Industrial Loft',
      location: 'Sapphire Street, USA',
      beds: 2,
      baths: 2,
      area: '1,800 sqft',
      price: '\$950,000',
      image: 'assets/images/home_3.png',
    ),
    PropertyCard(
      title: 'Scandinavian',
      location: 'Sapphire Street, USA',
      beds: 3,
      baths: 2,
      area: '2,400 sqft',
      price: '\$1,900,000',
      image: 'assets/images/home_3.png',
    ),
    // يمكنك إضافة المزيد بسهولة
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: GridView.builder(
        itemCount: propertyCards.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 1000 ? 4 : 2,
          crossAxisSpacing: 20.w,
          mainAxisSpacing: 20.h,
          childAspectRatio: 0.80,
        ),
        itemBuilder: (context, index) {
          return propertyCards[index];
        },
      ),
    );
  }
}
