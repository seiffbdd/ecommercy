import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either> signup({
    required String name,
    required String email,
    required String password,
  });

  Future sendVerificationCode({
    required String recepientEmail,
    String? recepientName,
    String? verificationCode,
  });

  Future<void> verifyEmail();
}
