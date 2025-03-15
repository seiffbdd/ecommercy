import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.rating,
  });
  final String image;
  final String title;
  final double price;
  final double? rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSize.screenWidth(context) / 3,
      height: ScreenSize.screenHeight(context) / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.kPrimaryBackgroundColor),
      ),
      child: Column(
        children: [
          SizedBox(
            height: ScreenSize.screenHeight(context) / 6,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.network(fit: BoxFit.fill, image),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                title,
                style: Styles.textStyle16,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              '\$${price.round()}',
              style: Styles.textStyle16.copyWith(color: AppColors.blueColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (rating != null)
            Row(
              children: [
                Icon(Icons.star, color: Colors.amberAccent),
                Text('$rating'),
              ],
            ),
        ],
      ),
    );
  }
}
