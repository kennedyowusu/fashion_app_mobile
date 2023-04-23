import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/services/shipping_Address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ShippingAddressController extends GetxController {
  final ShippingAddressService shippingAddressService =
      ShippingAddressService();

  final RxList<ShippingAddress> shippingAddress = <ShippingAddress>[].obs;

  final isLoading = false.obs;

  final GetStorage box = GetStorage();

  final currentUserId = GetStorage().read('currentUserId');

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
      await shippingAddressService.createShippingAddress(
        name: name,
        addressLineOne: address,
        city: city,
        state: state,
        zip: zip,
        phone: phone,
        userId: userId,
      );

      fetchShippingAddress();

      Future<void> storeShippingAddressLocally =
          box.write('shippingAddress', shippingAddress);

      storeShippingAddressLocally.then((value) {
        debugPrint('Shipping Address stored locally');
      }).catchError((error) {
        debugPrint('Shipping Address not stored locally');
      });

      isLoading(false);
    } catch (e) {
      isLoading(false);
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  bool hasShippingAddress() {
    return shippingAddress.isNotEmpty;
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
      await shippingAddressService.updateShippingAddress(
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
      await shippingAddressService.deleteShippingAddress(
        shippingAddressId: id,
      );
      fetchShippingAddress();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
