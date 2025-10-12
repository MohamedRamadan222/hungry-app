import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class SpicySlider extends StatefulWidget {
  const SpicySlider({super.key, required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  @override
  State<SpicySlider> createState() => _SpicySliderState();
}

class _SpicySliderState extends State<SpicySlider> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Image.asset('assets/detail/12.png', height: 250),
        ),
        Gap(20),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    'Customize Your Burger \n to Your Tastes.\n Ultimate Experience',
              ),
              Slider(
                min: 0,
                max: 1,
                value: widget.value,
                onChanged: widget.onChanged,
                inactiveColor: Colors.grey.shade300,
                activeColor: AppColors.primaryColor,
              ),
              Row(
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Gap(12),
                  CustomText(text: '🥶'),
                  Gap(90),
                  CustomText(text: '🌶'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
