part of 'get_user_info_cubit.dart';

@immutable
sealed class GetUserInfoState {}

final class GetUserInfoInitial extends GetUserInfoState {}

final class GetUserInfoLoading extends GetUserInfoState {}

final class GetUserInfoSuccess extends GetUserInfoState {}

final class GetUserInfoFailed extends GetUserInfoState {
  final String errMessage;
  GetUserInfoFailed({required this.errMessage});
}
