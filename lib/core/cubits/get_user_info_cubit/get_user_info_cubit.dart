import 'package:e_commercy/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_user_info_state.dart';

class GetUserInfoCubit extends Cubit<GetUserInfoState> {
  GetUserInfoCubit() : super(GetUserInfoInitial());

  UserModel? userModel;

  Future<void> saveUserInfo({required UserModel model}) async {
    emit(GetUserInfoLoading());
    userModel = model;
    emit(GetUserInfoSuccess());
  }
}
