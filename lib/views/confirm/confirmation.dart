import 'package:fashion_app/layout.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({
    super.key,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  String orderNumber = '1';
  String shippingAddress = '123 Main St, New York, NY 10001';
  String paymentMethod = 'Visa ending in 1234';
  double totalPrice = 100.0;
  DateTime estimatedDeliveryDate = DateTime.now().add(Duration(days: 3));
  List<String> itemsPurchased = [
    'Black T-Shirt',
    'Blue Jeans',
    'Red Sneakers',
  ];

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
            OrderData(orderInformation: "Order Number: \n$orderNumber"),
            Divider(),
            SizedBox(height: 16.0),
            OrderData(orderInformation: "Shipping Address: \n$shippingAddress"),
            Divider(),
            SizedBox(height: 16.0),
            OrderData(orderInformation: "Payment Method: \n$paymentMethod"),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              '3 Items Purchased:',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.separated(
                itemCount: itemsPurchased.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(itemsPurchased[index]),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 16.0),
            OrderData(
              orderInformation:
                  'Total Price: \n\$${totalPrice.toStringAsFixed(2)}',
            ),
            Divider(),
            SizedBox(height: 16.0),
            OrderData(
              orderInformation:
                  'Estimated Delivery Date: \n${estimatedDeliveryDate.toString()}',
            ),
            Divider(),
            SizedBox(height: 32.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Get.to(
                    () => MainLayout(),
                    transition: Transition.rightToLeft,
                  );
                },
                child: Text(
                  'Return Home',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text(
                  'Make Payment Now',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderData extends StatelessWidget {
  const OrderData({
    super.key,
    required this.orderInformation,
  });

  final String orderInformation;

  @override
  Widget build(BuildContext context) {
    return Text(
      orderInformation,
      style: TextStyle(fontSize: 16.0),
    );
  }
}
