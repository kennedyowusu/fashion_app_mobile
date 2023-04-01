import 'package:fashion_app/model/product_by_category.dart';
import 'package:fashion_app/services/category_products.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsByCategoryController extends GetxController {
  int categoryId;
  final RxBool isLoading = false.obs;

  ProductsByCategoryController({required this.categoryId});

  final RxList<ProductModel> productByCategory = <ProductModel>[].obs;

  @override
  onInit() {
    getProductsByCategory(categoryId);
    super.onInit();
  }

  Future<void> getProductsByCategory(int categoryId) async {
    isLoading(true);
    try {
      ProductByCategoryResponse categoryProductsResponse =
          await ProductsByCategoryService().getCategoryProducts(categoryId);

      productByCategory.assignAll(categoryProductsResponse.data);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
      debugPrint('Product By Category: $productByCategory');
    }
  }
}
