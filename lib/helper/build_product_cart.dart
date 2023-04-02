import 'package:fashion_app/views/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Stack buildProductCart() {
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
            '0',
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
