import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/models/property_model.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/image_picker_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_button.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_snack_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/manager/property_cubit/property_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/add_property_form_fields.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/add_property_image_picker.dart';
import 'package:go_router/go_router.dart';

class UpdatePropertyBottomSheet extends StatefulWidget {
  final PropertyModel property;

  const UpdatePropertyBottomSheet({super.key, required this.property});

  @override
  State<UpdatePropertyBottomSheet> createState() =>
      _UpdatePropertyBottomSheetState();
}

class _UpdatePropertyBottomSheetState extends State<UpdatePropertyBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController typeController;
  late TextEditingController locationController;
  late TextEditingController priceController;
  late TextEditingController descriptionController;
  late TextEditingController bedsController;
  late TextEditingController bathsController;
  late TextEditingController areaController;

  Uint8List? webImage;
  bool isUploading = false;
  final imageService = ImagePickerService.instance;

  @override
  void initState() {
    super.initState();

    // تعبئة الحقول بالقيم القديمة
    titleController = TextEditingController(text: widget.property.title);
    typeController = TextEditingController(text: widget.property.type);
    locationController = TextEditingController(text: widget.property.location);
    priceController = TextEditingController(
      text: widget.property.price.toString(),
    );
    descriptionController = TextEditingController(
      text: widget.property.description,
    );
    bedsController = TextEditingController(
      text: widget.property.beds.toString(),
    );
    bathsController = TextEditingController(
      text: widget.property.baths.toString(),
    );
    areaController = TextEditingController(text: widget.property.area);
  }

  @override
  void dispose() {
    titleController.dispose();
    typeController.dispose();
    locationController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    bedsController.dispose();
    bathsController.dispose();
    areaController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final img = await imageService.pickImageFromGallery();
    if (img != null && mounted) {
      setState(() => webImage = img);
    }
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isUploading = true);

    String imageUrl = widget.property.imageUrl;

    // إذا اختار صورة جديدة → نرفعها
    if (webImage != null) {
      final uploadedUrl = await imageService.uploadImageBytes(
        imageBytes: webImage!,
        bucket: "properties",
      );

      if (uploadedUrl == null) {
        setState(() => isUploading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(message: "Image upload failed", isError: true),
        );
        return;
      }

      imageUrl = uploadedUrl;
    }

    final cubit = context.read<PropertyCubit>();

    await cubit.updateProperty(
      id: widget.property.id,
      title: titleController.text.trim(),
      type: typeController.text.trim(),
      location: locationController.text.trim(),
      price: double.parse(priceController.text),
      description: descriptionController.text.trim(),
      beds: int.parse(bedsController.text),
      baths: int.parse(bathsController.text),
      area: areaController.text.trim(),
      imageUrl: imageUrl,
    );

    if (!context.mounted) return;
    context.pop();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(CustomSnackBar(message: "Property updated successfully"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Update Property",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const SizedBox(height: 20),

              AddPropertyImagePicker(
                webImage: webImage,
                networkImage: widget.property.imageUrl,
                onTap: _pickImage,
              ),
              const SizedBox(height: 24),

              AddPropertyFormFields(
                titleController: titleController,
                typeController: typeController,
                locationController: locationController,
                priceController: priceController,
                descriptionController: descriptionController,
                bedsController: bedsController,
                bathsController: bathsController,
                areaController: areaController,
              ),
              const SizedBox(height: 24),

              BlocBuilder<PropertyCubit, PropertyState>(
                builder: (context, state) {
                  final isLoading = state is PropertyLoading || isUploading;
                  return Center(
                    child: CustomButton(
                      isLoading: isLoading,
                      text: "Update Property",
                      onPressed: isLoading ? null : () => _submit(context),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
