import 'package:dartz/dartz.dart';
import 'package:e_commercy/features/auth/data/repos/auth_repo_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthRepoImpl authRepoImpl = AuthRepoImpl();

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    try {
      final Either response = await authRepoImpl.signup(
        name: name,
        email: email,
        password: password,
      );

      response.fold(
        (error) {
          emit(RegisterFailed(errMessage: error.toString()));
        },
        (data) {
          emit(Registersuccess());
        },
      );
    } catch (e) {
      emit(RegisterFailed(errMessage: e.toString()));
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      final Either response = await authRepoImpl.login(
        email: email,
        password: password,
      );

      response.fold(
        (error) {
          emit(LoginFailed(errMessage: error.toString()));
        },
        (data) {
          emit(Loginsuccess());
        },
      );
    } catch (e) {
      emit(RegisterFailed(errMessage: e.toString()));
    }
  }

  bool obscureText = true;
  void toggleobsecureText() {
    obscureText = !obscureText;
    emit(ObsecureTextToggled());
  }
}
