// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fashion_app/views/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/widgets/appbar.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final double imageHeight = isPortrait ? 300.0 : 200.0;
    final double detailsHeight = isPortrait ? 400.0 : 300.0;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Fashion Shop',
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
      bottomNavigationBar: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: !cartController.updatingCart.value &&
                              !cartController.cartItems
                                  .any((item) => item.id == product.id) &&
                              cartController.addingToCartError.value.isEmpty
                          ? Colors.white
                          : Colors.grey,
                      maximumSize: Size(100, 50),
                      // Disable button when cart is being updated
                      // or when the item is already in the cart
                      // or when there is an error adding to the cart
                      // Use the `onPressed` property to determine if the button is enabled or disabled
                      // based on the conditions below
                      backgroundColor: !cartController.updatingCart.value &&
                              !cartController.cartItems
                                  .any((item) => item.id == product.id) &&
                              cartController.addingToCartError.value.isEmpty
                          ? Colors.orange
                          : Colors.grey,
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: !cartController.updatingCart.value &&
                            !cartController.cartItems
                                .any((item) => item.id == product.id) &&
                            cartController.addingToCartError.value.isEmpty
                        ? () async {
                            // Set updatingCart to true to show loading state
                            cartController.updatingCart.value = true;
                            try {
                              // Add item to cart
                              cartController.addToCart(product, 1);
                              // Navigate to cart screen
                              Get.to(() => CartScreen(product: product));
                            } catch (e) {
                              // Set addingToCartError to show error message
                              cartController.addingToCartError.value =
                                  e.toString();
                            } finally {
                              // Set updatingCart to false to hide loading state
                              cartController.updatingCart.value = false;
                            }
                          }
                        : null, // Set `onPressed` to null to disable the button
                    child: Obx(
                      () {
                        if (cartController.updatingCart.value) {
                          // Show loading state if cart is being updated
                          return CircularProgressIndicator();
                        } else if (cartController.cartItems
                            .any((item) => item.id == product.id)) {
                          // Show disabled button if item is already in the cart
                          return Text(
                            'Already in cart',
                            style: TextStyle(color: Colors.grey),
                          );
                        } else {
                          return Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    product.stock = product.stock - 1;
                  },
                  child: Text(
                    'Buy Now',
                    style: TextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: imageHeight,
              width: double.infinity,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(),
                  child: Row(
                    children: [
                      Text(
                        'In Stock: ',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      CircleAvatar(
                        radius: 20.0,
                        backgroundColor:
                            product.stock > 0 ? Colors.orange : Colors.red,
                        child: Center(
                          child: Text(
                            '${product.stock}',
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.0),
                  child: Text(
                    '₵${product.price.toString()}',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              // height: detailsHeight,
              height: width * 0.6,
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Text(
                product.description,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
