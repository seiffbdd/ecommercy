part of 'verification_cubit.dart';

@immutable
sealed class VerificationState {}

final class VerificationInitial extends VerificationState {}

final class SendVerificationCodeLoading extends VerificationState {}

final class SendVerificationCodeSuccess extends VerificationState {}

final class SendVerificationCodeFailed extends VerificationState {
  final String errMessage;
  SendVerificationCodeFailed({required this.errMessage});
}

final class EmailVerifiedLoading extends VerificationState {}

final class BuyerVerifiedSuccess extends VerificationState {}

final class SellerVerifiedSuccess extends VerificationState {}

final class EmailVerifiedFailed extends VerificationState {
  final String errMessage;
  EmailVerifiedFailed({required this.errMessage});
}
