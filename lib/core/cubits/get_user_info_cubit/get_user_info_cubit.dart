import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  GetUserInfoCubit() : super(GetUserInfoInitial());

  UserModel? userModel;

  Future<void> saveUserInfo({required String userId}) async {
    emit(GetUserInfoLoading());
    try {
      final QuerySnapshot<Map<String, dynamic>> response =
          await getIt
              .get<FirebaseFirestore>()
              .collection(Strings.usersCollection)
              .where(
                'email',
                isEqualTo: FirebaseAuth.instance.currentUser!.email,
              )
              .get();
      userModel = UserModel.fromJson(response.docs.first.data());
      emit(GetUserInfoSuccess());
    } catch (e) {
      debugPrint('Error fetching user info: $e');
      emit(GetUserInfoFailed(errMessage: e.toString()));
    }
  }
}
