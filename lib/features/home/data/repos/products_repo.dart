import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';

abstract class ProductsRepo {
  Future<Either<String, List<ProductModel>>> getAllProducts();
}
