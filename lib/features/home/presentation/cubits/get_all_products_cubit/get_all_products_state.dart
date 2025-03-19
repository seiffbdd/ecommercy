part of 'get_all_products_cubit.dart';

@immutable
sealed class GetAllProductsState {}

final class GetAllProductsInitial extends GetAllProductsState {}

final class GetAllProductsLoading extends GetAllProductsState {}

final class GetAllProductsSuccess extends GetAllProductsState {
  final List<ProductModel> products;

  GetAllProductsSuccess({required this.products});
}

final class GetAllProductsFailed extends GetAllProductsState {
  final String errMessage;

  GetAllProductsFailed({required this.errMessage});
}
