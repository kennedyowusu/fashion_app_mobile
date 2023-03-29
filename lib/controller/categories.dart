import 'package:fashion_app/model/categories.dart';
import 'package:fashion_app/services/categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CategoriesController extends GetxController {
  final RxList<CategoriesModel> categories = <CategoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final token = GetStorage().read('token');
    if (token != null) {
      getCategories(token);
    }
  }

  Future<void> getCategories(String token) async {
    try {
      CategoriesResponse? categoriesResponse =
          await CategoriesService().getCategories(token);
      categories.value = categoriesResponse!.data;
      debugPrint('Categories: ${categories.length}');
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      debugPrint('Categories: $categories');
    }
  }
}
