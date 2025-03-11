import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DonnotHaveAnAccountRow extends StatelessWidget {
  const DonnotHaveAnAccountRow({super.key, this.textColor, this.buttonColor});
  final Color? textColor;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: Styles.textStyle18.copyWith(
            color: textColor ?? AppColors.whiteColor,
          ),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kRegisterView);
          },
          child: Text(
            'Sign Up',
            style: Styles.textStyle16.copyWith(
              color: buttonColor ?? AppColors.greenColor,
            ),
          ),
        ),
      ],
    );
  }
}
