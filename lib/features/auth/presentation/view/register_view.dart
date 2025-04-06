import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/assets_data.dart';
import 'package:e_commercy/core/utils/cache_helper.dart';
import 'package:e_commercy/core/utils/components.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/strings.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/auth/presentation/view_model/auth_cubit/auth_cubit.dart';
import 'package:e_commercy/features/auth/presentation/view/verify_email_view.dart';
import 'package:e_commercy/core/widgets/auth_button.dart';
import 'package:e_commercy/features/auth/presentation/view/widgets/center_progress_indicator_with_stack.dart';
import 'package:e_commercy/core/widgets/custom_text_form_field.dart';
import 'package:e_commercy/features/splash/presentation/views/widgets/already_have_an_account_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    context.read<AuthCubit>().obscureText = true;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Registersuccess) {
          _nameController.text = '';
          _passwordController.text = '';
          _confirmPasswordController.text = '';
          Navigator.of(context).push(
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider.value(
                    value: authCubit,
                    child: VerifyEmailView(email: _emailController.text),
                  ),
            ),
          );
          CacheHelper.prefs.setBool(Strings.isGuest, false);
        }
        if (state is RegisterFailed) {
          Components.showSnackBar(
            context,
            text: state.errMessage,
            color: AppColors.redColor,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Account')),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: ScreenSize.screenWidth(context) * 0.75,
                        child: Image.asset(AssetsData.eCommercyWord),
                      ),
                      sizedBoxHeight10,
                      Text(
                        'Create an account to start shopping',
                        style: Styles.textStyle20,
                        textAlign: TextAlign.center,
                      ),
                      sizedBoxHeight30,
                      CustomTextFormField(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        prefixIcon: Icon(Icons.person_outline),
                        controller: _nameController,
                      ),
                      sizedBoxHeight20,
                      CustomTextFormField(
                        labelText: 'Email Address',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      sizedBoxHeight20,
                      BlocBuilder<AuthCubit, AuthState>(
                        buildWhen:
                            (previous, current) =>
                                current is ObsecureTextToggled,
                        builder: (context, state) {
                          return CustomTextFormField(
                            onFieldSubmitted: (value) {
                              authCubit.obscureText = true;
                            },
                            contentPadding: EdgeInsets.fromLTRB(
                              12,
                              8.0,
                              12,
                              8.0,
                            ),
                            labelText: 'Password',
                            hintText: 'Create a password',
                            prefixIcon: Icon(Icons.lock),
                            controller: _passwordController,
                            obscureText: authCubit.obscureText,
                            suffix: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                authCubit.toggleobsecureText();
                              },
                              icon:
                                  authCubit.obscureText
                                      ? Icon(Icons.remove_red_eye)
                                      : Icon(Icons.remove_red_eye_outlined),
                            ),
                          );
                        },
                      ),
                      sizedBoxHeight20,
                      CustomTextFormField(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(Icons.lock),
                        controller: _confirmPasswordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          } else if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      sizedBoxHeight30,
                      AuthButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            authCubit.signup(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        text: 'Create Account',
                      ),
                      sizedBoxHeight20,
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Text(
                            '  Or continue with  ',
                            style: Styles.textStyle16,
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      sizedBoxHeight10,
                      AuthButton(
                        text: 'Google',
                        width: ScreenSize.screenWidth(context) * 0.5,
                        buttonColor: AppColors.kPrimaryBackgroundColor,
                        textColor: AppColors.blackColor,
                      ),
                      AlreayHaveAnAccountRow(
                        textColor: AppColors.blackColor,
                        buttonColor: AppColors.blueColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is RegisterLoading) {
                  return CenterProgressIndicatorWithStack();
                }
                return SizedBox.shrink(); // Hide if not loading
              },
            ),
          ],
        ),
      ),
    );
  }
}
