import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
import 'package:hungry_app/shared/custom_button.dart';
import 'package:hungry_app/shared/custom_snack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';
import '../widgets/custom_user_txt_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();
  UserModel? userModel;
  String? selectedImage;
  bool isLoading = false;

  AuthRepo authRepo = AuthRepo();

  ///Get Profile Data
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = "Error In Profile";
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  ///Update Profile Data
  Future<void> updateProfileData() async {
    try {
      final user = await authRepo.updateProfileData(
        name: _name.text.trim(),
        email: _email.text.trim(),
        address: _address.text.trim(),
        imagePath: selectedImage,
        visa: _visa.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack('Profile Uploaded'));
      setState(() => isLoading = true);
      setState(() => userModel = user);
      await getProfileData();
    } catch (e) {
      setState(() => isLoading = false);
      String errorMsg = "Failed To Update Profile";
      if (e is ApiError) errorMsg = e.message;
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  ///Pick Image
  Future<void> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  /// Logout
  Future<void> logout() async {
    await authRepo.logout();
    await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (c) => LoginView()),
    );
  }

  @override
  void initState() {
    getProfileData().then((v) {
      _name.text = userModel?.name ?? 'mohamed';
      _email.text = userModel?.email ?? 'mohamed@gmail.com';
      _address.text = userModel?.address ?? '55 El-mansora, A.R.E';
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userModel == null) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }
    return RefreshIndicator(
      displacement: 40,
      color: AppColors.primaryColor,
      onRefresh: () async {
        await getProfileData();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: AppColors.primaryColor,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Skeletonizer(
                enabled: userModel == null,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          image:
                              selectedImage != null && selectedImage!.isNotEmpty
                              ? DecorationImage(
                                  image: FileImage(File(selectedImage!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                          border: Border.all(
                            width: 1,
                            color: AppColors.primaryColor,
                          ),
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : (userModel?.image != null &&
                                  userModel!.image!.isNotEmpty)
                            ? Image.network(
                                userModel!.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, err, builder) =>
                                    Icon(Icons.person),
                              )
                            : Icon(Icons.person),
                      ),
                    ),
                    Gap(10),
                    CustomButton(
                      onTap: pickImage,
                      text: 'upload Image',
                      width: 140,
                      height: 40,
                      radius: 50,
                      color: Colors.white,
                      txtColor: AppColors.primaryColor,
                    ),
                    Gap(30),
                    CustomUserTxtField(controller: _name, label: 'Name'),
                    Gap(25),
                    CustomUserTxtField(controller: _email, label: 'Email'),
                    Gap(25),
                    CustomUserTxtField(controller: _address, label: 'Address'),
                    Gap(20),
                    Divider(),
                    Gap(10),
                    userModel?.visa == null
                        ? CustomUserTxtField(
                            controller: _visa,
                            label: 'Add Visa Card',
                            textInputType: TextInputType.number,
                          )
                        : ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 15,
                            ),
                            tileColor: Color(0xffF3F4F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            leading: Image.asset(
                              'assets/icons/visa.png',
                              width: 50,
                            ),
                            title: CustomText(
                              text: 'Debit card',
                              color: Colors.black,
                            ),
                            subtitle: CustomText(
                              text: userModel?.visa?.toString() ?? 'No Visa',
                              color: Colors.black,
                            ),
                            trailing: CustomText(
                              text: 'Default',
                              color: Colors.black,
                            ),
                          ),
                    Gap(400),
                  ],
                ),
              ),
            ),
          ),

          bottomSheet: Container(
            padding: EdgeInsets.symmetric(horizontal: 9),
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Edit Button
                isLoading
                    ? CupertinoActivityIndicator()
                    : GestureDetector(
                        onTap: updateProfileData,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              CustomText(
                                text: 'Edit Profile',
                                color: Colors.white,
                              ),
                              Gap(5),
                              Icon(CupertinoIcons.pencil, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                // Logout
                GestureDetector(
                  onTap: logout,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: 'Logout',
                          color: AppColors.primaryColor,
                        ),
                        Gap(10),
                        Icon(
                          Icons.logout,
                          color: AppColors.primaryColor,
                          size: 22,
                        ),
                      ],
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
