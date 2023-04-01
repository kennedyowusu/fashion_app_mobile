import 'dart:convert';
import 'dart:developer';

import 'package:fashion_app/model/product_by_category.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ProductsByCategoryService {
  Future<ProductByCategoryResponse> getCategoryProducts(
    int categoryId) async {
    try {
      final token = await GetStorage().read('token');
      final url = productsByCategoryUrl(categoryId);

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint("This is from Products By Category Service: ${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        debugger();

        debugPrint(jsonResponse);

        ProductByCategoryResponse categoryProductsResponse =
            ProductByCategoryResponse.fromJson(jsonResponse);

        debugPrint("categoryProducts: $categoryProductsResponse");

        return categoryProductsResponse;
      } else {
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      throw Exception('Failed to load products by category: $e');
    }
  }
}
