import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/core/widgets/custom_circle_prgress_indicator.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.rating,
    this.cardHeight,
    this.cardWidth,
  });
  final String image;
  final String title;
  final num price;
  final num? rating;
  final double? cardHeight;
  final double? cardWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: cardWidth ?? ScreenSize.screenWidth(context) / 3,
      height: cardHeight ?? ScreenSize.screenHeight(context) / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.primaryBackgroundColor),
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
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: image,
                placeholder: (context, url) => CustomCirclePrgressIndicator(),
                errorWidget:
                    (context, url, error) => const Icon(
                      Icons.image_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                title,
                style: Styles.textStyle16,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
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
