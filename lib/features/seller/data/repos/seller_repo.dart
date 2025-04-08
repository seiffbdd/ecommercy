import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';

abstract class SellerRepo {
  Future<Either<String, void>> addProduct({required ProductModel product});
}
