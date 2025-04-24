import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomDropdownButtonFormField extends StatelessWidget {
  const CustomDropdownButtonFormField({
    super.key,
    this.labelText,
    this.hintText,
    required this.onChanged,
    required this.items,
    this.validator,
  });
  final String? labelText;
  final String? hintText;
  final Function(String?)? onChanged;
  final List<String> items;
  final FormFieldValidator<String>? validator;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      style: Styles.textStyle20.copyWith(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
      ),
      dropdownColor: AppColors.primaryBackgroundColor,
      validator:
          validator ??
          (value) {
            if (value == null) {
              return 'Please select a category';
            }
            return null;
          },
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: Styles.textStyle18.copyWith(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: Styles.textStyle18.copyWith(color: AppColors.greyColor),
        alignLabelWithHint: true,

        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
      ),
      items:
          items.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
