import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/widgets/custom_button.dart';

import '../../../shared/custom_textField.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(100),
                SvgPicture.asset('assets/logo/logo.svg'),
                Gap(60),
                CustomTextField(
                  controller: nameController,
                  hint: 'Name',
                  isPassword: false,
                ),
                Gap(15),
                CustomTextField(
                  controller: emailController,
                  hint: 'Email Address',
                  isPassword: false,
                ),
                Gap(15),
                CustomTextField(
                  controller: passwordController,
                  hint: 'Password',
                  isPassword: true,
                ),
                Gap(15),
                CustomTextField(
                  controller: confirmPasswordController,
                  hint: 'Confirm Password',
                  isPassword: true,
                ),
                Gap(30),
                CustomButton(
                  text: 'Sign Up',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      print('success register');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
