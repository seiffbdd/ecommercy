import 'package:e_commercy/core/utils/cache_helper.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/features/auth/presentation/view/loading_view.dart';
import 'package:e_commercy/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:e_commercy/features/auth/presentation/view/login_view.dart';
import 'package:e_commercy/features/auth/presentation/view/register_view.dart';
import 'package:e_commercy/features/home/presentation/view_model/get_all_products_cubit/get_all_products_cubit.dart';
import 'package:e_commercy/features/home/presentation/view_model/get_new_arrivals_cubit/get_new_arrivals_cubit.dart';
import 'package:e_commercy/features/home/presentation/view/home_view.dart';
import 'package:e_commercy/features/seller/presentation/view/add_products_view.dart';
import 'package:e_commercy/features/seller/presentation/view_model/add_product_cubit/add_product_cubit.dart';
import 'package:e_commercy/features/splash/presentation/views/splash_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const registerView = '/register';
  static const loginView = '/login';
  static const homeView = '/home';
  static const addProductView = '/addProductView';
  static const splashView = '/splashView';

  static String get initialRoute {
    if (FirebaseAuth.instance.currentUser != null) {
      return '/';
    } else {
      if (CacheHelper.prefs.getBool(Strings.isGuest) == true) {
        return homeView;
      } else {
        return splashView;
      }
    }
  }

  static final router = GoRouter(
    initialLocation: initialRoute,

    routes: [
      GoRoute(path: splashView, builder: (context, state) => SplashView()),
      GoRoute(path: '/', builder: (context, state) => LoadingView()),

      GoRoute(
        path: registerView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: RegisterView(),
            ),
      ),

      GoRoute(
        path: loginView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AuthCubit(),
              child: LoginView(),
            ),
      ),
      GoRoute(
        path: homeView,
        builder:
            (context, state) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => GetAllProductsCubit()),
                BlocProvider(create: (context) => GetNewArrivalsCubit()),
              ],
              child: HomeView(),
            ),
      ),
      GoRoute(
        path: addProductView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AddProductCubit(),
              child: AddProductsView(),
            ),
      ),
    ],
  );
}
