import 'dart:convert';

import 'package:fashion_app/model/products.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductService {
  Future<ProductResponse?> getProducts(String token) async {
    try {
      final response = await http.get(
        Uri.parse(
          PRODUCTS_URL,
        ), // The URL of the API endpoint for getting products
        headers: {
          'Accept':
              'application/json', // Setting the 'Accept' header to JSON to receive JSON formatted response
          'Authorization':
              'Bearer $token' // Setting the 'Authorization' header to the JWT token passed as a parameter
        },
      );
      if (response.statusCode == 200) {
        // If the API call returns a 200 status code, indicating success
        final jsonResponse = jsonDecode(
          response.body,
        ); // Decode the response body from JSON to a Map
        final ProductResponse productResponse = ProductResponse.fromJson(
          jsonResponse,
        ); // Convert the decoded JSON Map to a ProductResponse object using the 'fromJson' factory method
        debugPrint(
          "products: $productResponse",
        ); // Print the fetched product data to the console for debugging
        return productResponse; // Return the fetched product data
      } else {
        // If the API call returns any other status code
        throw Exception(
            'Failed to load products'); // Throw an exception indicating that the API call failed
      }
    } catch (e) {
      // If an error occurs while making the API call
      throw Exception(
          'Failed to load products: $e'); // Throw an exception with the error message indicating the failure
    }
  }
}
