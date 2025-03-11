import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key, this.text, this.textStyle, this.onPressed});
  final String? text;
  final TextStyle? textStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.whiteColor,
      minWidth: ScreenSize.screenWidth(context) * 0.75,
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      onPressed: onPressed,
      child: Text(
        text ?? '',
        style:
            textStyle ??
            Styles.textStyle20.copyWith(color: AppColors.blueColor),
      ),
    );
  }
}
