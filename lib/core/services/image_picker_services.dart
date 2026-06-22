import 'dart:developer';
import 'dart:typed_data'; // 👈 للويب

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImagePickerService {
  ImagePickerService._();
  static final instance = ImagePickerService._();

  final ImagePicker _picker = ImagePicker();

  // اختيار صورة من المعرض (يدعم الويب)
  Future<Uint8List?> pickImageFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (picked == null) return null;
      return await picked.readAsBytes(); // 👈 نحولها إلى Uint8List
    } catch (e) {
      log("❌ Error picking image: $e");
      return null;
    }
  }

  // رفع الصورة إلى Supabase Storage (من Uint8List)
  Future<String?> uploadImageBytes({
    required Uint8List imageBytes,
    required String bucket,
  }) async {
    try {
      final storagePath =
          '${DateTime.now().millisecondsSinceEpoch}.png'; // 👈 اسم فريد للصورة

      final response = await Supabase.instance.client.storage
          .from(bucket)
          .uploadBinary(storagePath, imageBytes); // 👈 رفع من bytes مباشرة

      log("📤 Upload response: $response");

      if (response.isEmpty) {
        log("❌ Upload failed: empty response");
        return null;
      }

      final url = Supabase.instance.client.storage
          .from(bucket)
          .getPublicUrl(storagePath);

      log("✅ Uploaded image URL: $url");
      return url;
    } catch (e) {
      log("❌ Error uploading image: $e");
      return null;
    }
  }
}
