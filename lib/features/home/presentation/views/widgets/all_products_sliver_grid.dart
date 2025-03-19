import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/features/home/presentation/views/widgets/product_card.dart';
import 'package:flutter/material.dart';

class AllProductsSliverGrid extends StatelessWidget {
  const AllProductsSliverGrid({super.key, required this.products});
  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(child: Text('No Products Available')),
      );
    } else {
      return SliverGrid.builder(
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemBuilder: (context, index) {
          return ProductCard(
            image: products[index].image,
            title: products[index].title,
            price: products[index].price,
            rating: products[index].rating,
          );
        },
      );
    }
  }
}
