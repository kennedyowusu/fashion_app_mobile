import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/views/confirm/confirmation.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/button.dart';
import 'package:fashion_app/widgets/payment_widget.dart';
import 'package:fashion_app/widgets/paystack.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.shippingAddress});
  final ShippingAddress shippingAddress;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Select Payment Method',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              PaymentExpansionTile(
                icon: Icons.credit_card,
                title: 'Credit Card',
                subtitle: 'Not Available at the moment',
                color: Colors.red,
                child: Column(
                  children: [],
                ),
              ),
              SizedBox(height: 10),
              PaymentExpansionTile(
                icon: Icons.mobile_friendly,
                title: 'Mobile Banking',
                subtitle: '+233 *** *** ***',
                color: Colors.green,
                child: Column(
                  children: [],
                ),
              ),
              SizedBox(height: 10),
              PaymentExpansionTile(
                icon: Icons.account_balance_wallet,
                title: 'Online Banking',
                subtitle: 'Not Available at the moment',
                color: Colors.red,
                child: Column(
                  children: [],
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: PaymentExpansionTile(
                  icon: Icons.money_sharp,
                  title: 'Paystack',
                  subtitle: '',
                  color: Colors.green,
                  child: Column(
                    children: [
                      PaystackCard(
                        shippingAddress: widget.shippingAddress,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: Button(
          title: 'Pay On Delivery',
          onPressed: () {
            Get.to(
              () => ConfirmationScreen(
                shippingAddress: widget.shippingAddress,
              ),
            );
          },
          width: double.infinity,
          disable: true,
        ),
      ),
    );
  }
}
