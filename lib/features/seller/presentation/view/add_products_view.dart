import 'package:flutter/material.dart';

class AddProductsView extends StatelessWidget {
  const AddProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Product')),
      body: Center(child: Text('Add Products View')),
    );
  }
}
