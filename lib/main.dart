import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/cache_helper.dart';
import 'package:e_commercy/core/utils/service_locator.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await CacheHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  runApp(const ECommercy());
}

class ECommercy extends StatelessWidget {
  const ECommercy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.kPrimaryBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.whiteColor,
          centerTitle: true,
          titleTextStyle: Styles.textStyle25.copyWith(
            color: AppColors.blackColor,
          ),
        ),
      ),
    );
  }
}
