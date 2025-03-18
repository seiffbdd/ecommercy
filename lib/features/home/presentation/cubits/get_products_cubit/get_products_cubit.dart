import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/features/home/data/repos/products_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  GetProductsCubit() : super(GetProductsInitial());
  Future<void> getAllProducts() async {
    emit(GetProductsLoading());
    try {
      Either<String, List<ProductModel>> response =
          await getIt.get<ProductsRepo>().getAllProducts();
      response.fold(
        (errMessage) {
          emit(GetProductsFailed(errMessage: errMessage));
        },
        (products) {
          emit(GetProductsSuccess(products: products));
        },
      );
    } catch (e) {
      emit(GetProductsFailed(errMessage: e.toString()));
    }
  }
}
