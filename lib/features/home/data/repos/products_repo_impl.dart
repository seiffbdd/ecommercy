import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/home/data/repos/products_repo.dart';

class ProductsRepoImpl extends ProductsRepo {
  @override
  Future<Either<String, List<ProductModel>>> getAllProducts() async {
    try {
      final QuerySnapshot querySnapshot =
          await getIt
              .get<FirebaseFirestore>()
              .collection(Strings.productsCollection)
              .get();

      List<ProductModel> products = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          products.add(ProductModel.fromJson(data));
        }
      }
      return Right(products);
    } catch (e) {
      log('error from repo $e');
      return Left('Something went wrong!');
    }
  }
}
