import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/views/confirm/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaystackCard extends StatelessWidget {
  const PaystackCard({super.key, required this.shippingAddress});
  final ShippingAddress shippingAddress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('Paystack Card Tapped');
        Get.to(
          () => ConfirmationScreen(
            shippingAddress: shippingAddress,
          ),
        );
      },
      child: Container(
        width: 300.0,
        height: 180.0,
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/paystack_logo.jpeg',
                    width: 120.0,
                    height: 30.0,
                  ),
                  Image.asset(
                    'assets/images/chip.png',
                    width: 30.0,
                    height: 30.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'CARD HOLDER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
              child: Text(
                'Kennedy Owusu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                '**** **** **** 1234',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
              child: Row(
                children: [
                  Text(
                    'VALID THRU',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    '12/24',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
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
