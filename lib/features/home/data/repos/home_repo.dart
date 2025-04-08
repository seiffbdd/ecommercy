import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';

abstract class HomeRepo {
  Future<Either<String, List<ProductModel>>> getAllProducts();
  Future<Either<String, List<ProductModel>>> getNewArrivalsProducts();
  Future<Either<String, List<ProductModel>>> getAllProductsForSpecificCategory({
    required String category,
  });
  Future<Either<String, List<ProductModel>>>
  getNewArrivalsProductsForSpecificCategory({required String category});
}
