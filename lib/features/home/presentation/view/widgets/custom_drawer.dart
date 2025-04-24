import 'package:e_commercy/core/cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/components.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/verification/presentation/view/verify_email_view.dart';
import 'package:e_commercy/core/widgets/main_button.dart';
import 'package:e_commercy/features/verification/presentation/view_model/verification_cubit/verification_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: ScreenSize.screenWidth(context) * 0.6,
      backgroundColor: AppColors.whiteColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sizedBoxHeight30,
            Text(
              'Hello ${context.read<GetUserInfoCubit>().userModel?.name ?? 'Guest'}',
              style: Styles.textStyle25,
            ),
            sizedBoxHeight20,
            Divider(),
            sizedBoxHeight10,
            if (context.read<GetUserInfoCubit>().userModel != null &&
                context.read<GetUserInfoCubit>().userModel!.role ==
                    Strings.buyer)
              MainButton(
                text: 'Start Selling',
                textStyle: Styles.textStyle16.copyWith(
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => VerificationCubit(),
                            child: VerifyEmailView(
                              email: FirebaseAuth.instance.currentUser!.email!,
                              isSeller: true,
                            ),
                          ),
                    ),
                  );
                },
              ),
            if (context.read<GetUserInfoCubit>().userModel != null &&
                context.read<GetUserInfoCubit>().userModel!.role ==
                    Strings.seller)
              MainButton(
                text: 'Add Product',
                textStyle: Styles.textStyle16.copyWith(
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  context.push(AppRouter.addProductView);
                },
              ),

            sizedBoxHeight20,
            if (FirebaseAuth.instance.currentUser != null)
              MainButton(
                buttonColor: AppColors.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    sizedBoxWidth10,
                    Text('Logout', style: Styles.textStyle16),
                  ],
                ),
                onPressed: () {
                  Components.showCustomDialog(
                    context,
                    title: 'Logout',
                    content: 'Are you sure to logout?',
                    okButtonText: 'Logout',
                    onPressedOkButton: () async {
                      await FirebaseAuth.instance.signOut();

                      if (!context.mounted) return;
                      context.read<GetUserInfoCubit>().userModel = null;
                      context.go(AppRouter.loginView);
                    },
                    onPressedCancelButton: () {
                      context.pop();
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
