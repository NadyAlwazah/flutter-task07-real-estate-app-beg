import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupViewBody extends StatelessWidget {
  const SignupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 37.5.r,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 20.sp,
                  color: const Color.fromRGBO(0, 158, 207, 1.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
