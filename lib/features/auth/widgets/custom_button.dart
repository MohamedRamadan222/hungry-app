import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.color,
    this.txtColor,
  });

  final Function()? onTap;
  final String text;
  final double? width;
  final Color? color;
  final Color? txtColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: color ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white,
            width: 1.5,
          ),
        ),
        width: width,
        child: Center(
          child: CustomText(
            text: text,
            size: 15,
            weight: FontWeight.w500,
            color: txtColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
