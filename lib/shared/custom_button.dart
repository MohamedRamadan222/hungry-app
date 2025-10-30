import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.width,
    this.color,
    this.txtColor,
    this.height,
    this.radius,
  });

  final Function()? onTap;
  final String text;
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;
  final Color? txtColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 10),
        ),
        child: Center(
          child: CustomText(text: text, color: txtColor),
        ),
      ),
    );
  }
}
