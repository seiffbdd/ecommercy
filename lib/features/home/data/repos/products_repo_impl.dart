import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/home/data/repos/products_repo.dart';
import 'package:flutter/material.dart';

class ProductsRepoImpl extends ProductsRepo {
  @override
  Future<Either<String, List<ProductModel>>> getAllProducts({
    Category? category,
  }) async {
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
      debugPrint('error from repo $e');
      return Left('Something went wrong!');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getNewArrivalsProducts() async {
    try {
      final QuerySnapshot querySnapshot =
          await getIt
              .get<FirebaseFirestore>()
              .collection(Strings.productsCollection)
              .orderBy('id', descending: true)
              .limitToLast(10)
              .get();

      List<ProductModel> newArrivals = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          newArrivals.add(ProductModel.fromJson(data));
        }
      }
      return Right(newArrivals);
    } catch (e) {
      debugPrint('error from repo $e');
      return Left('Something went wrong!');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>> getAllProductsForSpecificCategory({
    required String category,
  }) async {
    try {
      final QuerySnapshot querySnapshot =
          await getIt
              .get<FirebaseFirestore>()
              .collection(Strings.productsCollection)
              .where(Strings.category, isEqualTo: category)
              .get();

      List<ProductModel> newArrivals = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          newArrivals.add(ProductModel.fromJson(data));
        }
      }
      return Right(newArrivals);
    } catch (e) {
      debugPrint('error from repo $e');
      return Left('Something went wrong!');
    }
  }

  @override
  Future<Either<String, List<ProductModel>>>
  getNewArrivalsProductsForSpecificCategory({required String category}) async {
    try {
      final QuerySnapshot querySnapshot =
          await getIt
              .get<FirebaseFirestore>()
              .collection(Strings.productsCollection)
              .where(Strings.category, isEqualTo: category)
              .orderBy('id', descending: true)
              .limitToLast(10)
              .get();

      List<ProductModel> newArrivals = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data != null && data is Map<String, dynamic>) {
          newArrivals.add(ProductModel.fromJson(data));
        }
      }
      return Right(newArrivals);
    } catch (e) {
      debugPrint('error from repo $e');
      return Left('Something went wrong!');
    }
  }
}
