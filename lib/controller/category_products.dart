import 'package:fashion_app/model/product_by_category.dart';
import 'package:fashion_app/services/category_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProductsByCategoryController extends GetxController {
  // Creating an observable list of ProductsByCategoryController
  final RxList<ProductModel> productByCategory = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    final token = GetStorage().read('token');
    final categoryId = GetStorage().read('categoryId');
    // If the token is not null, fetching category products using the token
    if (token != null && categoryId != null) {
      getCategoryProducts(token, categoryId);
    }
  }

  // A function to fetch products by category using an API call
  Future<void> getCategoryProducts(String token, int categoryId) async {
    try {
      // Making an HTTP GET request to fetch products by category
      ProductByCategoryResponse? categoryProductsResponse =
          await ProductsByCategoryService()
              .getCategoryProducts(token, categoryId);
      // Assigning the fetched data to the observable productByCategory list
      productByCategory.value = categoryProductsResponse.data;
      // Printing the length of the productByCategory list for debugging purposes
      debugPrint('Product By Category List is: ${productByCategory.length}');
    } catch (e) {
      // Printing any errors that occur during the API call for debugging purposes
      debugPrint('Error: $e');
    } finally {
      // Printing the observable productByCategory list for debugging purposes
      debugPrint('Product By Category: $productByCategory');
    }
  }
}
