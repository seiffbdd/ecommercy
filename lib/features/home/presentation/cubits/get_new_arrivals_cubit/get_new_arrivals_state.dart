part of 'get_new_arrivals_cubit.dart';

@immutable
sealed class GetNewArrivalsState {}

final class GetNewArrivalsInitial extends GetNewArrivalsState {}

final class GetNewArrivalsLoading extends GetNewArrivalsState {}

final class GetNewArrivalsSuccess extends GetNewArrivalsState {
  final List<ProductModel> products;

  GetNewArrivalsSuccess({required this.products});
}

final class GetNewArrivalsFailed extends GetNewArrivalsState {
  final String errMessage;

  GetNewArrivalsFailed({required this.errMessage});
}
