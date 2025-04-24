import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<Either> login({required String email, required String password});
}
