import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    this.text,
    this.textStyle,
    this.onPressed,
    this.buttonColor = AppColors.blueColor,
    this.textColor = AppColors.whiteColor,
    this.child,
    this.width,
    this.height,
  });
  final String? text;
  final TextStyle? textStyle;
  final void Function()? onPressed;
  final Color buttonColor;
  final Color textColor;
  final Widget? child;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      minWidth: width ?? ScreenSize.screenWidth(context),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide(color: AppColors.greyColor),
      ),
      disabledColor: buttonColor,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      onPressed: onPressed,
      color: buttonColor,
      child:
          child ??
          Text(
            text ?? '',
            style: textStyle ?? Styles.textStyle20.copyWith(color: textColor),
          ),
    );
  }
}
