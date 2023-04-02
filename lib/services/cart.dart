import 'dart:convert';

import 'package:fashion_app/model/cart.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class CartService {
  Future<List<CartModel>> getCartItems() async {
    final url = Uri.parse(CART_URL);

    try {
      final token = await GetStorage().read('token');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'] as List<dynamic>;

        List<CartModel> cartItems =
            jsonResponse.map((item) => CartModel.fromJson(item)).toList();

        debugPrint('Cart items: ${cartItems.length}');

        debugPrint('Cart items: $cartItems');

        return cartItems;
      } else {
        throw Exception('Failed to fetch cart items');
      }
    } catch (e) {
      debugPrint('Error fetching cart items: $e');
      throw Exception('Failed to fetch cart items: $e');
    }
  }

  Future<CartModel> addItemToCart(String cartId, CartModel cartItem) async {
    final url = Uri.parse(CART_URL);

    try {
      final token = await GetStorage().read('token');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(cartItem.toJson()),
      );

      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        CartModel cartResponse = CartModel.fromJson(jsonResponse["data"]);
        return cartResponse;
      } else {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  // Future<bool> removeItemFromCart(int cartId) async {
  //   final url = Uri.parse("$_baseUrl/carts/$cartId");

  //   try {
  //     final token = await GetStorage().read('token');
  //     final response = await http.delete(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $token',
  //       },
  //     );

  //     if (response.statusCode == 204) {
  //       return true;
  //     } else {
  //       throw Exception('Failed to remove item from cart');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to remove item from cart: $e');
  //   }
  // }
}
