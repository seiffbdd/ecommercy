import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/features/seller/data/repos/seller_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  Future<void> addProduct({required ProductModel product}) async {
    emit(AddProductLoading());
    try {
      Either<String, void> response = await getIt.get<SellerRepo>().addProduct(
        product: product,
      );
      response.fold(
        (errMessage) {
          emit(AddProductFailed(errMessage: errMessage));
        },
        (voidResult) {
          emit(AddProductSuccess());
        },
      );
    } catch (e) {
      debugPrint('Error from adding product cubit $e');
      emit(
        AddProductFailed(
          errMessage: 'Unable to add Product now, Please try again later!!',
        ),
      );
    }
  }

  static const List<String> categories = [
    'electronics',
    'books',
    'fashion',
    'home',
    'mobilePhones',
    'videoGames',
  ];
}
