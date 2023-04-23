import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/services/shipping_Address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShippingAddressController extends GetxController {
  final RxList<ShippingAddress> shippingAddress = <ShippingAddress>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShippingAddress();
  }

  Future<void> fetchShippingAddress() async {
    try {
      isLoading(true);
      ShippingAddressModelResponse shippingAddressModelResponse =
          await ShippingAddressService().fetchShippingAddress();
      shippingAddress.assignAll(shippingAddressModelResponse.data);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
      debugPrint('Shipping Address: $shippingAddress');
    }
  }

  Future<void> refreshShippingAddress() async {
    isLoading(true);
    final newShippingAddress = await ShippingAddressService()
        .fetchShippingAddress()
        .then((value) => value.data);
    shippingAddress.clear();
    shippingAddress.addAll(newShippingAddress);
    isLoading(false);
  }

  Future<void> createShippingAddress({
    required String name,
    required String address,
    required String city,
    required String state,
    required String zip,
    required String phone,
    required int userId,
  }) async {
    try {
      isLoading(false);
      await ShippingAddressService().createShippingAddress(
        name: name,
        addressLineOne: address,
        city: city,
        state: state,
        zip: zip,
        phone: phone,
        userId: userId,
      );
      fetchShippingAddress();
      isLoading(false);
    } catch (e) {
      isLoading(false);
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateShippingAddress({
    required int id,
    required String name,
    required String address,
    required String city,
    required String state,
    required String zip,
    required String phone,
    required int userId,
  }) async {
    try {
      await ShippingAddressService().updateShippingAddress(
        id: id,
        name: name,
        addressLineOne: address,
        city: city,
        state: state,
        zip: zip,
        phone: phone,
        userId: userId,
      );
      fetchShippingAddress();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> deleteShippingAddress({
    required int id,
  }) async {
    try {
      await ShippingAddressService().deleteShippingAddress(
        shippingAddressId: id,
      );
      fetchShippingAddress();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
