import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/user_home_view_body.dart';

class UserHomeView extends StatelessWidget {
  const UserHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFE8E8E8),
      body: UserHomeViewBody(),
    );
  }
}
