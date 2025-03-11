import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/assets_data.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/splash/presentation/views/widgets/already_have_an_account_row.dart';
import 'package:e_commercy/features/splash/presentation/views/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              SizedBox(
                width: ScreenSize.screenWidth(context) * 0.75,
                child: Image.asset(AssetsData.eCommercyWord),
              ),
              const SizedBox(height: 20),
              Text(
                'Your one-stop shopping destination',
                style: Styles.textStyle18.copyWith(color: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              RoundedButton(
                text: 'Get Started',
                onPressed: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kRegisterView);
                },
              ),
              sizedBoxHeight20,
              AlreayHaveAnAccountRow(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
