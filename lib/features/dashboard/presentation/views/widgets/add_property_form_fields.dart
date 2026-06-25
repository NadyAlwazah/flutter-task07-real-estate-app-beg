import 'package:flutter/material.dart';
import 'package:flutter_task07_real_estate_app_beg/core/utils/validators.dart';
import 'package:flutter_task07_real_estate_app_beg/features/dashboard/presentation/views/widgets/custom_text_field.dart';

class AddPropertyFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController typeController;
  final TextEditingController locationController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController bedsController;
  final TextEditingController bathsController;
  final TextEditingController areaController;

  const AddPropertyFormFields({
    super.key,
    required this.titleController,
    required this.typeController,
    required this.locationController,
    required this.priceController,
    required this.descriptionController,
    required this.bedsController,
    required this.bathsController,
    required this.areaController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: titleController,
                label: "Property Title",
                validator: Validators.validateField,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: typeController,
                label: "Property Type",
                validator: Validators.validateField,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: locationController,
                label: "Location",
                validator: Validators.validateField,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: priceController,
                label: "Price",
                keyboardType: TextInputType.number,
                validator: Validators.validateField,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: bedsController,
                label: "Number of Beds",
                keyboardType: TextInputType.number,
                validator: Validators.validateField,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: bathsController,
                label: "Number of Baths",
                keyboardType: TextInputType.number,
                validator: Validators.validateField,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: areaController,
          label: "Area (sq ft)",
          keyboardType: TextInputType.text,
          validator: Validators.validateField,
        ),
        const SizedBox(height: 16),

        CustomTextField(
          controller: descriptionController,
          label: "Description",
          keyboardType: TextInputType.text,
          validator: Validators.validateField,
          //!!!!!
          // maxLines: 3,
        ),
      ],
    );
  }
}
