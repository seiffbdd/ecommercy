import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.controller,
    this.prefixIcon,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffix,
    this.contentPadding,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.enabled = true,
    this.labelStyle,
  });
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final Icon? prefixIcon;
  final Widget? suffix;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onFieldSubmitted;
  final int maxLines;
  final AutovalidateMode autovalidateMode;
  final bool enabled;
  final TextStyle? labelStyle;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      autovalidateMode: autovalidateMode,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      style: Styles.textStyle20.copyWith(
        color: AppColors.blackColor,
        fontWeight: FontWeight.w500,
      ),
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      enabled: enabled,
      validator:
          validator ??
          (value) {
            if (value!.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
      decoration: InputDecoration(
        hintStyle: Styles.textStyle16.copyWith(color: AppColors.greyColor),
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,
        labelStyle:
            labelStyle ??
            Styles.textStyle16.copyWith(color: AppColors.lightBlackColor),
        filled: true,
        contentPadding: contentPadding,
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
        prefixIcon: prefixIcon,
        suffix: suffix,
      ),
      obscureText: obscureText,
    );
  }
}
