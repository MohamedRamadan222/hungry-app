import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_button.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_text.dart';
import '../../../shared/custom_snack.dart';
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
  bool isLoading = false;
  AuthRepo authRepo = AuthRepo();

  Future<void> signup() async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() => isLoading = true);
        final user = await authRepo.signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (user != null) {
          Navigator.push(context, MaterialPageRoute(builder: (c) => Root()));
        }
        setState(() => isLoading = false);
      } catch (e) {
        setState(() => isLoading = false);
        String errMsg = "Error in register";
        if (e is ApiError) {
          errMsg = e.message;
        }
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
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
            body: Form(
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
                    text: 'Welcome to our app',
                    size: 20,
                    weight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                  Gap(height * 0.06),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Gap(height * 0.03),
                            CustomTextField(
                              controller: nameController,
                              hint: 'Name',
                              isPassword: false,
                            ),
                            Gap(height * 0.02),
                            CustomTextField(
                              controller: emailController,
                              hint: 'Email Address',
                              isPassword: false,
                            ),
                            Gap(height * 0.02),
                            CustomTextField(
                              controller: passwordController,
                              hint: 'Password',
                              isPassword: true,
                            ),
                            Gap(height * 0.04),
                            isLoading ? CupertinoActivityIndicator(
                              color: Colors.white,
                            ):
                            CustomButton(
                              color: AppColors.primaryColor,
                              txtColor: Colors.white,
                              text: 'Sign Up',
                              onTap: signup,
                            ),
                            Gap(height * 0.02),
                            CustomButton(
                              color: Colors.white,
                              text: 'Go to login ?',
                              txtColor: AppColors.primaryColor,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (c) => const LoginView(),
                                  ),
                                );
                              },
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
    );
  }
}
