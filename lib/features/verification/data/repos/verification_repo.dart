import 'package:dartz/dartz.dart';

abstract class VerificationRepo {
  Future<Either<String, void>> sendVerificationCode({
    required String recepientEmail,
    String? recepientName,
    required String verificationCode,
  });

  Future<void> verifyEmail();

  Future<void> updateAccountToSeller();
}
