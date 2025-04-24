import 'package:e_commercy/core/cubits/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/widgets/custom_circle_prgress_indicator.dart';
import 'package:e_commercy/features/verification/presentation/view/verify_email_view.dart';
import 'package:e_commercy/features/verification/presentation/view_model/verification_cubit/verification_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoadingView extends StatefulWidget {
  const LoadingView({super.key});

  @override
  State<LoadingView> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingView> {
  @override
  void initState() {
    super.initState();
    if (FirebaseAuth.instance.currentUser != null) {
      _saveUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetUserInfoCubit, GetUserInfoState>(
      listener: (context, state) {
        if (state is GetUserInfoSuccess) {
          if (context.read<GetUserInfoCubit>().userModel!.isVerified == true) {
            context.push(AppRouter.homeView);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => BlocProvider(
                      create: (context) => VerificationCubit(),
                      child: VerifyEmailView(
                        email:
                            context.read<GetUserInfoCubit>().userModel!.email,
                      ),
                    ),
              ),
            );
          }
        }
      },
      child: Scaffold(body: CustomCirclePrgressIndicator()),
    );
  }

  Future<void> _saveUserInfo() async {
    await context.read<GetUserInfoCubit>().saveUserInfo();
  }
}
