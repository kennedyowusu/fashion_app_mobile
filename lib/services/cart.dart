import 'dart:convert';

import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:fashion_app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartService {
  Future<List<CartModel>> getCartItems() async {
    final url = Uri.parse(CART_URL);

    try {
      final token = await GetStorage().read('token');
      final currentUserId = await GetStorage().read('currentUserId');

      if (currentUserId == null) {
        throw Exception('User ID not found');
      }

      final userId = int.parse(currentUserId['id']);

      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'] as List<dynamic>;

        final cartItems = jsonResponse
            .where((item) => item['user_id'] == userId)
            .map((item) => CartModel.fromJson(item))
            .toList();

        debugPrint('Cart items: ${cartItems.length}');

        return cartItems;
      } else {
        throw Exception('Failed to fetch cart items');
      }
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
      throw Exception('Failed to fetch cart items: $e');
    }
  }

  Future<void> saveCartItem(CartModel item) async {
    final url = Uri.parse(CART_URL);

    try {
      final token = await GetStorage().read('token');
      final currentUserId = await GetStorage().read('currentUserId');

      if (currentUserId == null) {
        throw Exception('User ID not found');
      }

      final userId = int.parse(currentUserId['id']);

      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(item.copyWith(userId: userId).toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to save cart item');
      }
      debugPrint('Response body: ${response.body}');
    } catch (e) {
      debugPrint('Failed to save cart item: $e');
      throw Exception('Failed to save cart item: $e');
    }
  }

  Future<bool> removeItemFromCart(int cartId) async {
    final url = Uri.parse("$CART_URL/$cartId");

    debugPrint('URL: $url $cartId');

    try {
      final token = await GetStorage().read('token');
      final currentUserId = await GetStorage().read('currentUserId');

      if (currentUserId == null) {
        throw Exception('User ID not found');
      }

      final userId = int.parse(currentUserId['id']);

      // make HTTP request to delete cart item
      final response = await http.delete(
        url,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint('Response body: ${response.body}');

      // check if request was successful
      if (response.statusCode == 200) {
        // convert response body to JSON object
        final json = jsonDecode(response.body);

        if (json['data']['user_id'] == userId) {
          // show success message in snackbar
          // CustomSnackbar.show('Success', json['message']);
          return true;
        } else {
          CustomSnackbar.show('Error', 'Failed to remove item from cart');
          throw Exception('Failed to remove item from cart');
        }
      } else {
        CustomSnackbar.show('Error', 'Failed to remove item from cart');
        throw Exception('Failed to remove item from cart');
      }
    } catch (e) {
      CustomSnackbar.show('Error', 'Failed to remove item from cart');
      throw Exception('Failed to remove item from cart: $e');
    }
  }
}
