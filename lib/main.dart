import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/layout/responsive_layout.dart';

void main() {
  runApp(const RealEstateApp());
}

class RealEstateApp extends StatelessWidget {
  const RealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(),
    );
  }
}
