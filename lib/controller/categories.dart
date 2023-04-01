import 'package:fashion_app/model/categories.dart';
import 'package:fashion_app/services/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final RxList<CategoriesModel> categories = <CategoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
  }

  Future<void> getCategories() async {
    try {
      CategoriesResponse categoriesResponse =
          await CategoriesService().getCategories();
      categories.assignAll(categoriesResponse.data);
      debugPrint('Categories: ${categories.length}');
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint('Categories: $categories');
    }
  }
}
