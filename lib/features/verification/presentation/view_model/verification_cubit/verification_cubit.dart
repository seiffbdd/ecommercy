import 'dart:math';

import 'package:e_commercy/features/verification/data/repos/verification_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());

  final VerificationRepoImpl verificationRepoImpl = VerificationRepoImpl();
  int _verificationCode = 000000;

  Future<void> sendVerificationCode({required String recepientEmail}) async {
    emit(SendVerificationCodeLoading());
    Random random = Random();
    _verificationCode = 100000 + random.nextInt(900000);

    try {
      final response = await verificationRepoImpl.sendVerificationCode(
        recepientEmail: recepientEmail,
        verificationCode: _verificationCode.toString(),
      );
      response.fold(
        (error) {
          emit(SendVerificationCodeFailed(errMessage: error));
        },
        (_) {
          emit(SendVerificationCodeSuccess());
        },
      );
    } catch (e) {
      emit(
        SendVerificationCodeFailed(
          errMessage: 'Opps! Unable to send email now, please try again later',
        ),
      );
    }
  }

  Future<void> verifyEmail({required String code}) async {
    emit(EmailVerifiedLoading());
    try {
      if (code == _verificationCode.toString()) {
        await verificationRepoImpl.verifyEmail();

        emit(BuyerVerifiedSuccess());
      } else {
        emit(
          EmailVerifiedFailed(errMessage: 'Verification code is not correct'),
        );
      }
    } catch (e) {
      emit(EmailVerifiedFailed(errMessage: e.toString()));
    }
  }

  Future<void> updateAccountToSeller({required String code}) async {
    emit(EmailVerifiedLoading());
    try {
      if (code == _verificationCode.toString()) {
        await verificationRepoImpl.updateAccountToSeller();
        emit(SellerVerifiedSuccess());
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
