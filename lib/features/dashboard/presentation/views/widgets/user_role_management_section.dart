import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/auth_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/theme/app_colors.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/role_management_card.dart';

class UserRoleManagementSection extends StatefulWidget {
  const UserRoleManagementSection({super.key});

  @override
  State<UserRoleManagementSection> createState() =>
      _UserRoleManagementSectionState();
}

class _UserRoleManagementSectionState extends State<UserRoleManagementSection> {
  final auth = AuthServicesImpl.instance;

  late Future<List<Map<String, dynamic>>> _future;

  @override
  void initState() {
    super.initState();
    _future = auth.getAllAccounts();
  }

  void _refresh() {
    setState(() {
      _future = auth.getAllAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CupertinoActivityIndicator(
              radius: 15,
              color: AppColors.primary,
            ),
          );
        }

        final accounts = snapshot.data!;

        //  فصل الـ users عن الـ admins
        final users = accounts.where((e) => e["role"] == "user").toList();
        final admins = accounts.where((e) => e["role"] == "admin").toList();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- USERS SECTION ----------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Users",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: users.isEmpty
                        ? const Center(
                            child: Text(
                              "No users found",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(right: 12, left: 12),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return RoleManagementCard(
                                onDelete: auth.deleteAccount,

                                user: users[index],
                                onUpdate: auth.updateAccountRole,
                                onRefresh: _refresh,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24),

            // ---------------- ADMINS SECTION ----------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Admins",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Expanded(
                    child: admins.isEmpty
                        ? const Center(
                            child: Text(
                              "No admins found",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            itemCount: admins.length,
                            itemBuilder: (context, index) {
                              return RoleManagementCard(
                                onDelete: auth.deleteAccount,
                                user: admins[index],
                                onUpdate: auth.updateAccountRole,
                                onRefresh: _refresh,
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
