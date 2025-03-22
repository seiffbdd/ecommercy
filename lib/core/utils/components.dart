import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

abstract class Components {
  static void showSnackBar(
    BuildContext context, {
    required String text,
    TextStyle textStyle = Styles.textStyle20,
    Color? color,
    int seconds = 3,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text, style: textStyle, textAlign: TextAlign.center),
        backgroundColor: color,
        duration: Duration(seconds: seconds),
      ),
    );
  }

  static showCustomDialog(
    BuildContext context, {
    required Function() onPressedCancelButton,
    required Function() onPressedOkButton,
    required String title,
    String? content,
    String cancelButtonText = 'Cancel',
    String okButtonText = 'Ok',
  }) async {
    return await showDialog(
      context: context,
      builder:
          (context) => SimpleDialog(
            title: Text(
              title,
              style: Styles.textStyle25.copyWith(fontWeight: FontWeight.w400),
            ),
            backgroundColor: AppColors.whiteColor,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 12.0,
                  left: 12.0,
                  right: 12.0,
                ),
                child: Text(content ?? '', style: Styles.textStyle20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: onPressedCancelButton,
                    child: Text(
                      cancelButtonText,
                      style: Styles.textStyle20.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: onPressedOkButton,
                    child: Text(
                      okButtonText,
                      style: Styles.textStyle20.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    );
  }
}
