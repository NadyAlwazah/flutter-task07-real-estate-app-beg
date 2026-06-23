import 'package:flutter_task07_real_estate_app_beg/core/services/firestore_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/api_paths.dart';

class DashboardTopBarServices {
  DashboardTopBarServices._();
  static final instance = DashboardTopBarServices._();

  Future<Map<String, dynamic>> getAdminData(String uid) async {
    return await FirestoreServices.instance.getDocument<Map<String, dynamic>>(
      path: ApiPaths.admin(uid),
      builder: (data, id) => data,
    );
  }
}
