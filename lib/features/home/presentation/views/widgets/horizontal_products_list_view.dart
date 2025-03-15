import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HorizontalProductsListView extends StatelessWidget {
  const HorizontalProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      physics: BouncingScrollPhysics(),
      separatorBuilder: (context, index) {
        return sizedBoxWidth10;
      },
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return ProductCard(
          image:
              'https://images.macrumors.com/t/t0HGgkcxSch3BjyR0h1ouAm-pTM=/1600x0/article-new/2024/09/iphone-16-design.jpg',
          title: 'iphone 16 pro',
          price: 8000,
        );
      },
    );
  }
}
