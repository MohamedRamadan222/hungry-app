import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/view/signup_view.dart';
import 'package:hungry_app/root.dart';

import '../../../shared/custom_text.dart';
import '../../../shared/custom_textField.dart';
import '../widgets/custom_button.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
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
                  text: 'Welcome Back , Be ThankFull',
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
                          CustomButton(
                            color: AppColors.primaryColor,
                            txtColor: Colors.white,
                            text: 'Login',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (c) => const LoginView(),
                                ),
                              );
                            },
                          ),
                          Gap(height * 0.02),
                          CustomButton(
                            color: Colors.white,
                            text: 'Create New Account ?',
                            txtColor: AppColors.primaryColor,
                            onTap: () {
                              Navigator.push(
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
    );
  }
}
