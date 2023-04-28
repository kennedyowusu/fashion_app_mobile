import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/layout.dart';
import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/widgets/appbar.dart';
import 'package:fashion_app/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({
    super.key,
    required this.shippingAddress,
  });

  final ShippingAddress shippingAddress;

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  String orderNumber = '1';
  String paymentMethod = 'Paystack';
  double totalPrice = 100.0;
  DateTime estimatedDeliveryDate = DateTime.now().add(Duration(days: 3));
  List<String> itemsPurchased = [
    'Black T-Shirt',
    'Blue Jeans',
    'Red Sneakers',
  ];

  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final cartItems = cartController.cartItems;
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
            Divider(),
            SizedBox(height: 16.0),
            OrderData(
              orderInformation:
                  "Shipping Address: \n${widget.shippingAddress.addressLine1}, ${widget.shippingAddress.city}, ${widget.shippingAddress.state}",
            ),
            Divider(),
            SizedBox(height: 16.0),
            OrderData(orderInformation: "Payment Method: \n$paymentMethod"),
            Divider(),
            SizedBox(height: 16.0),
            Text(
              '${cartItems.length} Items Purchased',
              style: TextStyle(fontSize: 16.0),
            ),
            Divider(),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cartItems[index].name),
                  );
                },
              ),
            ),
            Divider(),
            SizedBox(height: 16.0),
            OrderData(
              orderInformation:
                  'Total Price: \n\$${cartController.totalAmount.toStringAsFixed(2)}',
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
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialog();
                    },
                  );
                },
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
