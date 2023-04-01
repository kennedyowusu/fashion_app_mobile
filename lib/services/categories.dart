import 'dart:convert';

import 'package:fashion_app/model/categories.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CategoriesService {
  Future<CategoriesResponse> getCategories() async {
    try {
      final token = await GetStorage().read('token');
      final response = await http.get(
        Uri.parse(CATEGORIES_URL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        CategoriesResponse categoriesResponse =
            CategoriesResponse.fromJson(jsonResponse);
        debugPrint("categories: $categoriesResponse");
        return categoriesResponse;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }
}

