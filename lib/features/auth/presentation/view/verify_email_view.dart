import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/app_router.dart';
import 'package:e_commercy/core/utils/components.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:e_commercy/core/widgets/auth_button.dart';
import 'package:e_commercy/features/auth/presentation/view/widgets/center_progress_indicator_with_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({
    super.key,
    required this.email,
    this.isSeller = false,
  });
  final String email;
  final bool isSeller;
  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  late TextEditingController _codeController;
  @override
  void initState() {
    super.initState();
    _codeController = TextEditingController();
    context.read<AuthCubit>().sendVerificationCode(
      recepientEmail: widget.email,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is EmailVerifiedFailed) {
          Components.showSnackBar(
            context,
            text: state.errMessage,
            color: AppColors.redColor,
          );
        }
        if (state is BuyerVerifiedSuccess) {
          Components.showSnackBar(
            context,
            text: 'Email verified successfully',
            color: AppColors.greenColor,
          );

          GoRouter.of(context).go(AppRouter.kHomeView);
        }
        if (state is SellerVerifiedSuccess) {
          Components.showSnackBar(
            context,
            text: 'Your Email successfully, you can sell products now',
            color: AppColors.greenColor,
          );
          GoRouter.of(context).pop();
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
                        widget.isSeller
                            ? 'Verify your email to start selling'
                            : 'Enter Verification Code',
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
                          if (widget.isSeller) {
                            context.read<AuthCubit>().updateAccountToSeller(
                              code: _codeController.text,
                            );
                          } else {
                            context.read<AuthCubit>().verifyEmail(
                              code: _codeController.text,
                            );
                          }
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
                  return CenterProgressIndicatorWithStack();
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
