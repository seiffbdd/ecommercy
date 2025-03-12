import 'dart:developer' as dev;
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/features/auth/data/repos/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      final Either response = await getIt<AuthRepo>().signup(
        name: name,
        email: email,
        password: password,
      );

      response.fold(
        (error) {
          emit(RegisterFailed(message: error.toString()));
        },
        (data) {
          emit(Registersuccess());
        },
      );
    } catch (e) {
      emit(RegisterFailed(message: e.toString()));
    }
  }

  int verificationCode = 000000;

  Future<void> sendVerificationCode({
    required String recepientEmail,
    String? recepientName,
  }) async {
    emit(SendVerificationCodeLoading());
    Random random = Random();
    verificationCode = 100000 + random.nextInt(900000);

    try {
      await getIt.get<AuthRepo>().sendVerificationCode(
        recepientEmail: recepientEmail,
        verificationCode: verificationCode.toString(),
      );
      dev.log('email sent cubit');
      emit(SendVerificationCodeSuccess());
    } catch (e) {
      dev.log('cubit ${e.toString()}');
      emit(
        SendVerificationCodeFailed(
          errMessage: 'Unable to send code now, please try again later',
        ),
      );
    }
  }

  bool obscureText = true;
  void toggleobsecureText() {
    obscureText = !obscureText;
    emit(ObsecureTextToggled());
  }

  Future<void> verifyEmail({required String code}) async {
    emit(EmailVerifiedLoading());
    try {
      if (code == verificationCode.toString()) {
        await getIt.get<AuthRepo>().verifyEmail();
        emit(EmailVerifiedSuccess());
      } else {
        emit(
          EmailVerifiedFailed(errMessage: 'Verification code is not correct'),
        );
      }
    } catch (e) {
      emit(EmailVerifiedFailed(errMessage: e.toString()));
    }
  }
}
