import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final int? orderNumber;
  final String? shippingAddress;
  final String? paymentInfo;
  final double? totalAmount;
  // final DateTime? estimatedDeliveryDate = DateTime.now().add(Duration(days: 3));
  final DateTime? estimatedDeliveryDate;

  const OrderConfirmationScreen({
    super.key,
    this.orderNumber,
    this.shippingAddress,
    this.paymentInfo,
    this.totalAmount,
    this.estimatedDeliveryDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Order Confirmation',
        leadingIcon: FaIcon(
          FontAwesomeIcons.chevronLeft,
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderConfirmationData(
              orderConfirmationInformation: "Order Details: \n$orderNumber",
            ),
            SizedBox(height: 16.0),
            OrderConfirmationData(
              orderConfirmationInformation: 'Order Number: \n$orderNumber',
            ),
            SizedBox(height: 8.0),
            OrderConfirmationData(
              orderConfirmationInformation:
                  'Shipping Address: \n$shippingAddress',
            ),
            SizedBox(height: 8.0),
            OrderConfirmationData(
                orderConfirmationInformation:
                    'Payment Information: \n$paymentInfo'),
            SizedBox(height: 8.0),
            // OrderConfirmationData(orderConfirmationInformation: 'Total Amount: \$${totalAmount!.toStringAsFixed(2)}'),
            // SizedBox(height: 8.0),
            OrderConfirmationData(
              orderConfirmationInformation:
                  'Estimated Delivery Date: \n${estimatedDeliveryDate.toString()}',
            ),

            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send Confirmation',
                  style: TextStyle(fontSize: 20.0),
                ),
                Switch(
                  value: true,
                  onChanged: (bool value) {
                    // Send confirmation email or push notification
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Contact Support',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            // Display contact information for customer support, such as a phone number or email address
          ],
        ),
      ),
    );
  }
}

class OrderConfirmationData extends StatelessWidget {
  const OrderConfirmationData({
    super.key,
    required this.orderConfirmationInformation,
  });

  final String orderConfirmationInformation;

  @override
  Widget build(BuildContext context) {
    return Text(
      orderConfirmationInformation,
      style: TextStyle(fontSize: 16.0),
    );
  }
}
