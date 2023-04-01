import 'dart:convert';
import 'dart:developer';

import 'package:fashion_app/model/product_by_category.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsByCategoryService {
  // A function that returns a Future of ProductByCategoryResponse object
  // which represents the list of products under a certain category
  Future<ProductByCategoryResponse> getCategoryProducts(
      String token, int categoryId) async {
    try {

      final url = productsByCategoryUrl(categoryId);

      final response = await http.get(
        // Using the productsByCategoryUrl function from endpoints.dart
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint("This is from Products By Category Service: ${response.body}");

      // If the response status code is 200, it means the request was successful
      if (response.statusCode == 200) {
        // Decoding the response body (JSON) into a Map using jsonDecode method
        final jsonResponse = jsonDecode(response.body);

        // Pause the program at this point
        debugger();

        debugPrint(jsonResponse);

        // Creating a ProductByCategoryResponse object from the decoded JSON data
        ProductByCategoryResponse categoryProductsResponse =
            ProductByCategoryResponse.fromJson(jsonResponse);

        // Logging the category products response to the console for debugging purposes
        debugPrint("categoryProducts: $categoryProductsResponse");

        // Returning the category products response object
        return categoryProductsResponse;

        // If the response status code is not 200, it means the request failed
      } else {
        // Throwing an Exception with a message indicating the failure reason
        throw Exception('Failed to load products by category');
      }
    } catch (e) {
      // Throwing an Exception with a message indicating the failure reason
      throw Exception('Failed to load products by category: $e');
    }
  }
}
