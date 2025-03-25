import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/features/home/presentation/view/widgets/product_card.dart';
import 'package:flutter/material.dart';

class HorizontalProductsListView extends StatelessWidget {
  const HorizontalProductsListView({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Center(child: Text('No Products Available'));
    } else {
      return ListView.separated(
        itemCount: products.length,
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return sizedBoxWidth10;
        },
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return ProductCard(
            image: products[index].image,
            title: products[index].title,
            price: products[index].price,
          );
        },
      );
    }
  }
}
