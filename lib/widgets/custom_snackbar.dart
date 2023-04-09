import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show(String message) {
    Get.snackbar(
      'Success',
      message,
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      backgroundColor: Colors.black.withOpacity(0.8),
      colorText: Colors.white,
      borderRadius: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 500),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }
}
