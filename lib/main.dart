import 'package:e_commercy/core/cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/cache_helper.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/firebase_options.dart';
import 'package:e_commercy/core/utils/app_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = AppBlocObserver();
  setup();
  runApp(const Ecommercy());
}

class Ecommercy extends StatelessWidget {
  const Ecommercy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetUserInfoCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: AppColors.primaryBackgroundColor,
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.whiteColor,
            centerTitle: true,
            titleTextStyle: Styles.textStyle25.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
