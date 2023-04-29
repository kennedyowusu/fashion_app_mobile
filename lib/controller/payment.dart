import 'dart:io';

import 'package:fashion_app/constants/key.dart';
import 'package:fashion_app/controller/cart_controller.dart';
import 'package:fashion_app/controller/user.dart';
import 'package:fashion_app/views/payment/payment_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  RxBool isExpanded = false.obs;
  PaystackPlugin paystackPlugin = PaystackPlugin();

  final CartController cartController = Get.put(CartController());
  final UserController userController = Get.put(UserController());

  @override
  void onInit() {
    super.onInit();
    paystackPlugin.initialize(publicKey: ConstantKey.PAYSTACK_PUBLIC_KEY);
  }

  String getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  PaymentCard getCardFromUI() {
    return PaymentCard(
      number: '4123450131001381',
      cvc: '883',
      expiryMonth: 12,
      expiryYear: 23,
    );
  }

  void toggle() {
    isExpanded.value = !isExpanded.value;
  }

  Future<void> makePayment() async {
    final charge = Charge()
      ..amount = cartController.totalAmount.toInt() * 100 // In base currency
      ..email = userController.user.value.email
      ..currency = "GHS"
      ..reference = getReference()
      ..card = getCardFromUI()
      ..accessCode = "access code from previous transaction";

    final checkoutResponse = await paystackPlugin.checkout(
      Get.context!,
      method: CheckoutMethod
          .selectable, // Specify the payment method (card, bank, etc.)
      charge: charge,
      fullscreen: false,
      logo: Image.asset(
        'assets/images/paystack.png',
        height: 50,
        width: 50,
      ),
    );

    debugPrint('Checkout Response => $checkoutResponse');

    if (checkoutResponse.status == true) {
      Get.to(() => PaymentSuccessScreen());
    } else {
      Fluttertoast.showToast(
        msg: 'Payment Failed',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
