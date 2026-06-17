import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/app/routes.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/styles.dart';

class DonotHaveAnAccountWidget extends StatelessWidget {
  const DonotHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(AppRouter.kSignup);
          },
          child: const Text("Sign up", style: Styles.authAction),
        ),
      ],
    );
  }
}
