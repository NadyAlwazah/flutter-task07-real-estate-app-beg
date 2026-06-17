import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';
import 'package:go_router/go_router.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Already have an account ",
          style: TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: const Text("Sign In", style: Styles.authAction),
        ),
      ],
    );
  }
}
