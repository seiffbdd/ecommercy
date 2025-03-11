import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlreayHaveAnAccountRow extends StatelessWidget {
  const AlreayHaveAnAccountRow({super.key, this.textColor, this.buttonColor});
  final Color? textColor;
  final Color? buttonColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: Styles.textStyle18.copyWith(
            color: textColor ?? AppColors.whiteColor,
          ),
        ),
        TextButton(
          onPressed: () {
            GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
          },
          child: Text(
            'Login',
            style: Styles.textStyle16.copyWith(
              color: buttonColor ?? AppColors.greenColor,
            ),
          ),
        ),
      ],
    );
  }
}
