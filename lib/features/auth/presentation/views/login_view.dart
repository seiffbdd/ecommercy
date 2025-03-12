import 'package:e_commercy/core/utils/app_colors.dart';
import 'package:e_commercy/core/utils/constants.dart';
import 'package:e_commercy/core/utils/screen_size.dart';
import 'package:e_commercy/core/utils/styles.dart';
import 'package:e_commercy/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:e_commercy/features/auth/presentation/views/widgets/auth_button.dart';
import 'package:e_commercy/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:e_commercy/features/splash/presentation/views/widgets/donnot_have_an_account_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<LoginView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authCubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                sizedBoxHeight10,
                Text(
                  'Welcome Back!',
                  style: Styles.textStyle30,
                  textAlign: TextAlign.center,
                ),

                sizedBoxHeight20,
                Text(
                  'Sign in to continue shopping',
                  style: Styles.textStyle20,
                  textAlign: TextAlign.center,
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
                /*BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return CustomTextFormField(
                      contentPadding: EdgeInsets.fromLTRB(12, 8.0, 12, 8.0),
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
                */
                BlocBuilder<AuthCubit, AuthState>(
                  buildWhen:
                      (previous, current) => current is ObsecureTextToggled,
                  builder: (context, state) {
                    return CustomTextFormField(
                      onFieldSubmitted: (value) {
                        authCubit.obscureText = true;
                      },
                      contentPadding: EdgeInsets.fromLTRB(12, 8.0, 12, 8.0),
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.lock),
                      controller: _passwordController,
                      obscureText: authCubit.obscureText,
                      textInputAction: TextInputAction.done,
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
                sizedBoxHeight10,

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // waiting to handle with bloc
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Styles.textStyle16.copyWith(
                        color: AppColors.blueColor,
                      ),
                    ),
                  ),
                ),
                sizedBoxHeight10,
                AuthButton(text: 'Sign In', onPressed: () {}),
                sizedBoxHeight20,
                Row(
                  children: [
                    Expanded(child: Divider()),
                    Text('  Or continue with  ', style: Styles.textStyle16),
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
                DonnotHaveAnAccountRow(
                  textColor: AppColors.blackColor,
                  buttonColor: AppColors.blueColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
