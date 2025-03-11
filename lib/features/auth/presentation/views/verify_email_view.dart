import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/show_snack_bar.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commercy/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key, required this.email});
  final String email;

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late TextEditingController _codeController;
  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is EmailVerifiedFailed) {
          showSnackBar(
            context,
            text: state.errMessage,
            color: AppColors.redColor,
          );
        }
        if (state is EmailVerifiedSuccess) {
          showSnackBar(
            context,
            text: 'Email verified successfilly',
            color: AppColors.greenColor,
          );
          GoRouter.of(context).push(AppRouter.kHomeView);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Verify Email')),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 16.0,
                left: 16.0,
                bottom: 16.0,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 70,
                        color: AppColors.blueColor,
                      ),
                      sizedBoxHeight30,
                      Text(
                        'Enter Verification Code',
                        style: Styles.textStyle30,
                        textAlign: TextAlign.center,
                      ),
                      sizedBoxHeight10,
                      Text(
                        'We have sent a verification code to ${widget.email}',
                        style: Styles.textStyle18,
                        textAlign: TextAlign.center,
                      ),
                      sizedBoxHeight30,
                      PinCodeTextField(
                        controller: _codeController,
                        appContext: context,
                        length: 6,
                        keyboardType: TextInputType.number,
                        cursorColor: AppColors.blueColor,
                        enableActiveFill: true,
                        textStyle: Styles.textStyle30,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          fieldWidth: 50,
                          inactiveColor: AppColors.greyColor,
                          activeFillColor: Colors.transparent,
                          selectedColor: AppColors.greyColor,
                          selectedFillColor: Colors.transparent,
                          inactiveFillColor: Colors.transparent,
                          borderWidth: 1,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      sizedBoxHeight30,
                      AuthButton(
                        buttonColor: AppColors.blueColor,
                        text: 'Verify',
                        onPressed: () {
                          authCubit.verifyEmail(code: _codeController.text);
                        },
                      ),
                      sizedBoxHeight30,
                      Text(
                        'Didn\'t receive the code?',
                        style: Styles.textStyle16,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Resend Code',
                          style: Styles.textStyle20.copyWith(
                            color: AppColors.blueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is EmailVerifiedLoading) {
                  return Container(
                    color: Colors.black.withValues(
                      alpha: 0.5,
                    ), // Transparent black background
                    child: Center(
                      child: CircularProgressIndicator(), // Loading Indicator
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
