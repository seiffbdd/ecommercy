import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/models/product_model.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/features/home/data/repos/products_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit() : super(GetAllProductsInitial());
  Future<void> getAllProducts({required String category}) async {
    emit(GetAllProductsLoading());
    try {
      late Either<String, List<ProductModel>> response;
      if (category.toLowerCase() == 'all') {
        response = await getIt.get<ProductsRepo>().getAllProducts();
      } else {
        response = await getIt
            .get<ProductsRepo>()
            .getAllProductsForSpecificCategory(category: category);
      }
      response.fold(
        (errMessage) {
          emit(GetAllProductsFailed(errMessage: errMessage));
        },
        (products) {
          emit(GetAllProductsSuccess(products: products));
        },
      );
    } catch (e) {
      emit(GetAllProductsFailed(errMessage: e.toString()));
    }
  }

  String selectedCategory = 'all';
  static const List<Widget> tabs = [
    Tab(child: Text('All')),
    Tab(child: Text('Electronics')),
    Tab(child: Text('Books')),
    Tab(child: Text('Fashion')),
    Tab(child: Text('Home')),
    Tab(child: Text('Mobile Phones')),
    Tab(child: Text('Video Games')),
  ];

  static const List<String> categories = [
    'all',
    'electronics',
    'books',
    'fashion',
    'home',
    'mobilePhones',
    'videoGames',
  ];
}
