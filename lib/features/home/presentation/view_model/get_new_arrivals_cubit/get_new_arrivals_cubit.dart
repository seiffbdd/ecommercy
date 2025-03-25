import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/features/home/data/repos/products_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_new_arrivals_state.dart';

class GetNewArrivalsCubit extends Cubit<GetNewArrivalsState> {
  GetNewArrivalsCubit() : super(GetNewArrivalsInitial());

  Future<void> getNewArrivalsProducts({required String category}) async {
    emit(GetNewArrivalsLoading());
    try {
      late Either<String, List<ProductModel>> response;
      if (category.toLowerCase() == 'all') {
        response = await getIt.get<ProductsRepo>().getNewArrivalsProducts();
      } else {
        response = await getIt
            .get<ProductsRepo>()
            .getNewArrivalsProductsForSpecificCategory(category: category);
      }
      response.fold(
        (errMessage) {
          emit(GetNewArrivalsFailed(errMessage: errMessage));
        },
        (products) {
          emit(GetNewArrivalsSuccess(products: products));
        },
      );
    } catch (e) {
      emit(GetNewArrivalsFailed(errMessage: e.toString()));
    }
  }
}
