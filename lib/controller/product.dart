import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/services/products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductsController extends GetxController {
  final RxList products =
      [].obs; // RxList to store the products data, initialized as empty
  final RxBool isLoading = false
      .obs; // RxBool to indicate if data is currently being loaded, initialized as false
  final box = GetStorage().read('token'); // read token from local storage

  @override
  void onInit() {
    super.onInit();
    final token = GetStorage().read('token');
    if (token != null) {
      fetchProducts(token); // fetch products data if token is not null
    }
  }

  Future<void> fetchProducts(String token) async {
    try {
      isLoading.value =
          true; // set isLoading to true to indicate that data is currently being loaded
      final ProductResponse? productsResponse = await ProductService()
          .getProducts(token); // fetch products data using ProductService
      products.value = productsResponse?.data ??
          []; // update products RxList with fetched data, or set to empty list if data is null
      debugPrint(
        'Products: ${products.length}',
      ); // print number of products fetched
    } catch (e) {
      debugPrint('Error: $e'); // print error if fetching data fails
    } finally {
      isLoading.value =
          false; // set isLoading back to false after data has been loaded (or failed to load)
      debugPrint('Products: $products'); // print updated products data
    }
  }
}
