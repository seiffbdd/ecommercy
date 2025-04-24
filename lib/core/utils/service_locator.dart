import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commercy/core/utils/dio_helper.dart';
import 'package:e_commercy/features/home/data/repos/home_repo.dart';
import 'package:e_commercy/features/home/data/repos/home_repo_impl.dart';
import 'package:e_commercy/features/seller/data/repos/seller_repo.dart';
import 'package:e_commercy/features/seller/data/seller_repo_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<DioHelper>(DioHelper());

  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);

  getIt.registerSingleton<HomeRepo>(HomeRepoImpl());

  getIt.registerSingleton<SellerRepo>(SellerRepoImpl());
}
