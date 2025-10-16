import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

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

  @override
  void initState() {
    _name.text = 'mohamed';
    _email.text = 'mohamed@gmail.com';
    _address.text = '55 El-mansora, A.R.E';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(width: 5, color: Colors.white),
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Gap(30),
                CustomUserTxtField(controller: _name, label: 'Name'),
                Gap(25),
                CustomUserTxtField(controller: _email, label: 'Email'),
                Gap(25),
                CustomUserTxtField(controller: _address, label: 'Address'),
                Divider(),
                Gap(10),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 15,
                  ),
                  tileColor: Color(0xffF3F4F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: Image.asset('assets/icons/visa.png', width: 50),
                  title: CustomText(text: 'Debit card', color: Colors.black),
                  subtitle: CustomText(
                    text: '3566 **** **** 0505',
                    color: Colors.black,
                  ),
                  trailing: CustomText(text: 'Default', color: Colors.black),
                ),
                Gap(400)
              ],
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Edit Profile', color: Colors.white),
                    Gap(5),
                    Icon(CupertinoIcons.pencil, color: Colors.white),
                  ],
                ),
              ),
              // Logout
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    CustomText(text: 'Logout', color: AppColors.primaryColor),
                    Gap(10),
                    Icon(Icons.logout, color: AppColors.primaryColor, size: 22),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
