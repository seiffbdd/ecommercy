import 'package:dartz/dartz.dart';
import 'package:e_commercy/features/auth/data/models/user_model.dart';

abstract class AuthRepo {
  Future<Either> signup({required UserModel user});

  Future sendVerificationCode({
    required String recepientEmail,
    String? recepientName,
    String? verificationCode,
  });

  Future<void> verifyEmail();
}
