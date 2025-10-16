import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/shared/custom_text.dart';
import '../../../shared/custom_button.dart';
import '../widgets/order_details_widget.dart';
import '../widgets/success_dialog.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedPaymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Order Summary',
                  size: 20,
                  weight: FontWeight.w500,
                ),
                Gap(10),
                OrderDetailsWidget(
                  order: '20.00',
                  taxes: '2.00',
                  fees: '1.00',
                  total: '23.00',
                ),
                Gap(80),
                CustomText(
                  text: 'Payment Method',
                  size: 20,
                  weight: FontWeight.w500,
                ),
                Gap(20),
                // Cash
                ListTile(
                  onTap: () => setState(() => selectedPaymentMethod = 'Cash'),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  tileColor: Color(0xff3C2F2F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: Image.asset('assets/icons/cash.png', width: 50),
                  title: CustomText(
                    text: 'Cash on Delivery',
                    color: Colors.white,
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: 'Cash',
                    groupValue: selectedPaymentMethod,
                    onChanged: (v) {
                      setState(() => selectedPaymentMethod = v!);
                    },
                  ),
                ),
                Gap(10),
                // Debit Card
                ListTile(
                  onTap: () => setState(() => selectedPaymentMethod = 'Visa'),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 2,
                    horizontal: 15,
                  ),
                  tileColor: Colors.blue.shade800,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  leading: Image.asset('assets/icons/visa2.png', width: 50),
                  title: CustomText(text: 'Debit card', color: Colors.white),
                  subtitle: CustomText(
                    text: '3566 **** **** 0505',
                    color: Colors.white,
                  ),
                  trailing: Radio<String>(
                    activeColor: Colors.white,
                    value: 'Visa',
                    groupValue: selectedPaymentMethod,
                    onChanged: (v) {
                      setState(() => selectedPaymentMethod = v!);
                    },
                  ),
                ),
                Gap(5),
                Row(
                  children: [
                    Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2),
                      ),
                      activeColor: Color(0xffEF2A39),
                      value: true,
                      onChanged: (v) {},
                    ),
                    CustomText(
                      text: 'Save this card for future payments',
                      size: 12,
                      color: Colors.grey.shade600,
                    ),
                  ],
                ),
                Gap(200),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade800,
                blurRadius: 15,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 100,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: 'Total', size: 16),
                    CustomText(text: '\$ 18.9', size: 24),
                  ],
                ),
                CustomButton(
                  text: 'Pay Now',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SuccessDialog();
                      },
                    );
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
