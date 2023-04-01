import 'package:fashion_app/model/product_by_category.dart';
import 'package:fashion_app/services/category_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsByCategoryController extends GetxController {
  int categoryId;

  ProductsByCategoryController({required this.categoryId});

  final RxList<ProductModel> productByCategory = <ProductModel>[].obs;

  @override
  onInit() {
    getCategoryProducts(categoryId);
    super.onInit();
  }

  Future<void> getCategoryProducts(int categoryId) async {
    try {
      ProductByCategoryResponse categoryProductsResponse =
          await ProductsByCategoryService().getCategoryProducts(categoryId);

      productByCategory.assignAll(categoryProductsResponse.data);

      debugPrint('Product By Category List is: ${productByCategory.length}');
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint('Product By Category: $productByCategory');
    }
  }
}
