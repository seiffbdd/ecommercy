import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/seller/data/repos/seller_repo.dart';
import 'package:flutter/widgets.dart';

class SellerRepoImpl extends SellerRepo {
  @override
  Future<Either<String, void>> addProduct({
    required ProductModel product,
  }) async {
    try {
      final docProducts =
          getIt
              .get<FirebaseFirestore>()
              .collection(Strings.productsCollection)
              .doc();
      product.date = Timestamp.now();
      await docProducts.set(product.toJson());
      return Right(null);
    } catch (e) {
      debugPrint('Error from adding product repo $e');
      return Left(e.toString());
    }
  }
}
