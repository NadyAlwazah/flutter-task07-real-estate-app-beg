import 'package:flutter/cupertino.dart';
import 'package:flutter_task07_real_estate_app_beg/features/home/presentation/views/widgets/sidebar_user_section.dart';

class UserHomeViewBody extends StatefulWidget {
  const UserHomeViewBody({super.key});

  @override
  State<UserHomeViewBody> createState() => _UserHomeViewBodyState();
}

class _UserHomeViewBodyState extends State<UserHomeViewBody> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SidebarUserSection(
          onItemSelected: (index) {
            setState(() => selectedIndex = index);
          },
        ),
      ],
    );
  }
}
