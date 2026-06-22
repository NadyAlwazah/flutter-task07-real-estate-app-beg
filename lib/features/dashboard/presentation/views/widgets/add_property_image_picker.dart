import 'dart:typed_data';
import 'package:flutter/material.dart';

class AddPropertyImagePicker extends StatelessWidget {
  final VoidCallback onTap;
  final Uint8List? webImage;

  const AddPropertyImagePicker({super.key, required this.onTap, this.webImage});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
          image: webImage != null
              ? DecorationImage(
                  image: MemoryImage(webImage!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: webImage == null
            ? const Center(
                child: Text(
                  "Tap to upload property image",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : null,
      ),
    );
  }
}
