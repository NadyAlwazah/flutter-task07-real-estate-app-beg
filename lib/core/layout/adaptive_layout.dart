import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/widgets/small_screen_view.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({super.key, required this.wideScreenView});

  final Widget wideScreenView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          return wideScreenView;
        }

        return const SmallScreenView();
      },
    );
  }
}
