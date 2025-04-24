import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/auth/data/models/user_model.dart';
import 'package:e_commercy/features/auth/data/repos/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl();
  @override
  Future<Either> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final UserModel user = UserModel(
        name: name,
        email: email,
        role: Strings.buyer,
      );
      await getIt
          .get<FirebaseFirestore>()
          .collection(Strings.usersCollection)
          .doc(userCredential.user!.uid)
          .set(user.toJson());

      return Right('User created successfully');
    } on FirebaseAuthException catch (e) {
      return Left(e.code.replaceAll('-', ' '));
    } catch (e) {
      return Left('Opps! An error occurred, please try  again later');
    }
  }

  @override
  Future<Either> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Right('User signed in successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return left('Invalid email or password');
      } else if (e.code == 'user-token-expired') {
        return left('This email is nolonger authenticated');
      }
      return Left(e.code.replaceAll('-', ' '));
    } catch (e) {
      return Left('Opps! An error occurred, please try  again later');
    }
  }
}
