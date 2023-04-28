import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/views/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Stack buildProductCart() {
  final CartController cartController = Get.put(CartController());
  return Stack(
    children: [
      IconButton(
        padding: EdgeInsets.only(left: 10, top: 10.0),
        onPressed: () {
          Get.to(
            () => CartScreen(),
          );
        },
        icon: Icon(
          Icons.shopping_cart,
          color: Colors.black,
          size: 30,
        ),
      ),
      Positioned(
        top: 5,
        right: 10,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10),
          ),
          constraints: BoxConstraints(
            minWidth: 16,
            minHeight: 16,
          ),
          child: Text(
            '${cartController.cartItems.length}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 8,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}
