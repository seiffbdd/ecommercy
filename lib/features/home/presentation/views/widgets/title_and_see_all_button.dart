import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class TitleAndSeeAllButton extends StatelessWidget {
  const TitleAndSeeAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'New Arrivals',
          style: Styles.textStyle20.copyWith(fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'See All',
            style: Styles.textStyle16.copyWith(
              color: AppColors.blueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
