import 'package:fashion_app/helper/config.dart';
import 'package:fashion_app/views/checkout/checkout.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class NoShippingAddressesFound extends StatelessWidget {
  const NoShippingAddressesFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'No Shipping Address',
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
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 100.0,
              backgroundColor: Colors.grey[200],
              child: Icon(
                Icons.location_on,
                size: 150.0,
                color: Config.primaryColor,
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'No Shipping Addresses Found',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Text(
              'Please add a shipping address to proceed with your order',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            SizedBox(height: 20.0),
            Button(
              disable: false,
              width: double.infinity,
              onPressed: () {
                Get.to(() => CheckoutScreen());
              },
              title: 'Add Shipping Address',
            ),
          ],
        ),
      ),
    );
  }
}
