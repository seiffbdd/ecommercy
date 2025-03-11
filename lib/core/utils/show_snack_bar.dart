import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

void showSnackBar(
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
