import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text.dart';

class OrderDetailsWidget extends StatelessWidget {
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
  });

  final String order, taxes, fees, total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        checkoutWidget('Order', order, false),
        Gap(10),
        checkoutWidget('Taxes', taxes, false),
        Gap(10),
        checkoutWidget('Delivery fees', fees, false),
        Gap(10),
        Divider(),
        Gap(10),
        checkoutWidget('Total', total, true),
        Gap(15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: 'Estimated Delivery Time',
              size: 13,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
            CustomText(
              text: '25 min',
              size: 13,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}

Widget checkoutWidget(title, price, isBold)
{
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: title,
        size: 15,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
      CustomText(
        text: '\$$price',
        size: 15,
        weight: isBold ? FontWeight.bold : FontWeight.w400,
        color: isBold ? Colors.black : Colors.grey.shade600,
      ),
    ],
  );
}
