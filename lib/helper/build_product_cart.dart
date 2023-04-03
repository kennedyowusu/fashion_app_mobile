import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/views/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Stack buildProductCart() {
  final CartController cartController = Get.put(CartController());
  return Stack(
    children: [
      IconButton(
        onPressed: () {
          Get.to(
            () => CartScreen(),
          );
        },
        icon: Icon(Icons.shopping_cart),
      ),
      Positioned(
        top: 0,
        right: 12,
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
