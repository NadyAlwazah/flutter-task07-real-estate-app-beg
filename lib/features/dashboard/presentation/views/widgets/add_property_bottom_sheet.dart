import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task07_real_estate_app_beg/core/services/image_picker_services.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/styles.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_button.dart';
import 'package:flutter_task07_real_estate_app_beg/core/widgets/custom_snack_bar.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/manager/property_cubit/property_cubit.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/add_property_form_fields.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/add_property_image_picker.dart';
import 'package:go_router/go_router.dart';

class AddPropertyBottomSheet extends StatefulWidget {
  const AddPropertyBottomSheet({super.key});

  @override
  State<AddPropertyBottomSheet> createState() => _AddPropertyBottomSheetState();
}

class _AddPropertyBottomSheetState extends State<AddPropertyBottomSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController bedsController = TextEditingController();
  final TextEditingController bathsController = TextEditingController();
  final TextEditingController areaController = TextEditingController();

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

  Uint8List? webImage;
  bool isUploading = false;
  final imageService = ImagePickerService.instance;

  Future<void> _pickImage() async {
    final img = await imageService.pickImageFromGallery();
    if (img != null && mounted) {
      setState(() => webImage = img);
    }
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    if (webImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: "Please select an image", isError: true),
      );
      return;
    }

    setState(() => isUploading = true);

    final imageUrl = await imageService.uploadImageBytes(
      imageBytes: webImage!,
      bucket: "properties",
    );
    if (!context.mounted) return;

    if (imageUrl == null) {
      setState(() => isUploading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: "Image upload failed", isError: true),
      );
      return;
    }

    final cubit = context.read<PropertyCubit>();

    await cubit.addProperty(
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
    ).showSnackBar(CustomSnackBar(message: "Property added successfully"));
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
              Text("Add New Property", style: Styles.textStyle22Bold),
              const SizedBox(height: 20),

              AddPropertyImagePicker(webImage: webImage, onTap: _pickImage),
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

              BlocConsumer<PropertyCubit, PropertyState>(
                listenWhen: (previous, current) => current is PropertyError,
                listener: (context, state) {
                  if (state is PropertyError) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      CustomSnackBar(message: state.message, isError: true),
                    );
                  }
                },
                buildWhen: (previous, current) =>
                    current is PropertyLoading || current is PropertyError,
                builder: (context, state) {
                  final isLoading = state is PropertyLoading || isUploading;
                  return Center(
                    child: CustomButton(
                      isLoading: isLoading,
                      text: "Add Property",
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
