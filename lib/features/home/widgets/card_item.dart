import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

import '../../../shared/custom_text.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
    required this.rate,
  });

  final String image, title, desc, rate;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(image, width: 120, height: 120)),
            Gap(15),
            CustomText(text: title, weight: FontWeight.bold),
            CustomText(text: desc),
            SizedBox(
              width: 125,
              child: Row(
                children: [
                  SvgPicture.asset('assets/logo/star.svg', width: 15),
                  Gap(2),
                  CustomText(text: rate),
                  Spacer(),
                  Icon(
                    CupertinoIcons.heart_fill,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
