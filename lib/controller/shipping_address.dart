import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/services/shipping_Address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  final RxList<ShippingAddress> shippingAddress = <ShippingAddress>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchShippingAddress();
  }

  Future<void> fetchShippingAddress() async {
    try {
      ShippingAddressModelResponse shippingAddressModelResponse =
          await ShippingAddressService().fetchShippingAddress();
      shippingAddress.assignAll(shippingAddressModelResponse.data);
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint('Shipping Address: $shippingAddress');
    }
  }

  Future<void> createShippingAddress({
    required String name,
    required String address,
    required String city,
    required String state,
    required String zip,
    required String phone,
  }) async {
    try {
      await ShippingAddressService().createShippingAddress(
        name: name,
        addressLineOne: address,
        city: city,
        state: state,
        zip: zip,
        phone: phone,
      );
      fetchShippingAddress();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
