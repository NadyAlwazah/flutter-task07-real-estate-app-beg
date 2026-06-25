import 'package:flutter/cupertino.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double radius;
  final Color? color;

  const AppLoader({super.key, this.radius = 15, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      radius: radius,
      color: color ?? AppColors.primary,
    );
  }
}
