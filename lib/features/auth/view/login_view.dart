import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/view/signup_view.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_snack.dart';

import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
import '../widgets/custom_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final user = await authRepo.login(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Root()));
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);
        String errorMsg = "unhandled error in login";
        if (e is ApiError) {
          errorMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Gap(height * 0.12),
                    SvgPicture.asset(
                      'assets/logo/logo.svg',
                      colorFilter: ColorFilter.mode(
                        AppColors.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    Gap(height * 0.012),
                    CustomText(
                      text: 'Welcome back, be thankful',
                      color: AppColors.primaryColor,
                      size: 13,
                      weight: FontWeight.w500,
                    ),
                    Gap(height * 0.2),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Gap(height * 0.02),
                              CustomTextField(
                                controller: emailController,
                                hint: 'Email Address',
                                isPassword: false,
                              ),
                              Gap(height * 0.025),
                              CustomTextField(
                                controller: passwordController,
                                hint: 'Password',
                                isPassword: true,
                              ),
                              Gap(height * 0.04),
                              // Login Button
                              isLoading
                                  ? CupertinoActivityIndicator(
                                      color: Colors.white,
                                    )
                                  : CustomButton(
                                      color: AppColors.primaryColor,
                                      txtColor: Colors.white,
                                      text: 'Login',
                                      onTap: login,
                                    ),
                              Gap(height * 0.02),
                              // SignIn
                              CustomButton(
                                color: Colors.white,
                                text: 'Sign Up',
                                txtColor: AppColors.primaryColor,
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => const SignupView(),
                                    ),
                                  );
                                },
                              ),
                              Gap(height * 0.02),
                              // Guest Button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (c) => Root()),
                                  );
                                },
                                child: CustomText(
                                  text: 'Continue as Guest ?',
                                  color: Colors.orangeAccent,
                                  size: 13,
                                  weight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
