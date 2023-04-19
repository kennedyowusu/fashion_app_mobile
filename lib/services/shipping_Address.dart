import 'dart:convert';

import 'package:fashion_app/helper/api_exception.dart';
import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ShippingAddressService {
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String jsonContentType = 'application/json';
  static const String jsonAcceptType = 'application/json';

  Future<ShippingAddressModelResponse> fetchShippingAddress() async {
    final url = Uri.parse(SHIPPING_ADDRESS_URL);

    try {
      final token = await GetStorage().read('token');
      final currentUserId = await GetStorage().read('currentUserId');

      debugPrint("Current User ID: $currentUserId");

      if (currentUserId == null) {
        throw Exception('User ID not found');
      }

      final userId = int.parse(currentUserId);

      final response = await http.get(
        url,
        headers: {
          acceptHeader: jsonAcceptType,
          contentTypeHeader: jsonContentType,
          authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'] as List<dynamic>;

        final shippingAddress = jsonResponse
            .where((item) => item['user_id'] == userId)
            .map((item) => ShippingAddress.fromJson(item))
            .toList();

        debugPrint('Shipping Address: ${shippingAddress.length}');

        return ShippingAddressModelResponse(
          data: shippingAddress,
        );
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        throw ApiException(errorMessage, response.statusCode);
      }
    } catch (e) {
      throw ApiException('Failed to fetch shipping address', null);
    }
  }

  Future<void> createShippingAddress({
    String? name,
    String? addressLineOne,
    String? addressLineTwo,
    String? city,
    String? state,
    String? zip,
    String? phone,
    int? userId,
  }) async {
    final Map<String, dynamic> data = {
      'name': name,
      'address_line_1': addressLineOne,
      'address_line_2': addressLineTwo,
      'city': city,
      'state': state,
      'zip': zip,
      'phone': phone,
      'user_id': userId,
    };

    final url = Uri.parse(SHIPPING_ADDRESS_URL);

    try {
      final token = await GetStorage().read('token');
      final currentUserId = await GetStorage().read('currentUserId');

      debugPrint("Current User ID: $currentUserId");

      if (currentUserId == null) {
        throw Exception('User ID not found');
      }

      final parsedCurrentUserId = int.parse(currentUserId);

      if (userId != null && userId != parsedCurrentUserId) {
        throw Exception(
          'Only the current user can create their shipping address.',
        );
      }

      final response = await http.post(
        url,
        headers: {
          acceptHeader: jsonAcceptType,
          contentTypeHeader: jsonContentType,
          authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        debugPrint(jsonResponse.toString());
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        debugPrint(errorMessage);
        throw ApiException(errorMessage, response.statusCode);
      }
    } catch (e) {
      throw ApiException('Failed to create shipping address', null);
    }
  }

  Future<void> updateShippingAddress({
    required int id,
    required String name,
    required String addressLineOne,
    required String city,
    required String state,
    required String zip,
    required String phone,
    required int userId,
  }) async {
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
      'address_line_1': addressLineOne,
      'city': city,
      'state': state,
      'zip': zip,
      'phone': phone,
      'user_id': userId,
    };

    final url = Uri.parse('$SHIPPING_ADDRESS_URL/$id');

    try {
      final token = await GetStorage().read('token');

      final response = await http.put(
        url,
        headers: {
          acceptHeader: jsonAcceptType,
          contentTypeHeader: jsonContentType,
          authorizationHeader: 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        debugPrint(jsonResponse.toString());
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        debugPrint(errorMessage);
        throw Exception('Failed to update shipping address');
      }
    } catch (e) {
      throw Exception('Failed to update shipping address');
    }
  }

  Future<void> deleteShippingAddress({
    required int shippingAddressId,
  }) async {
    final url = Uri.parse('$SHIPPING_ADDRESS_URL/$shippingAddressId');

    try {
      final token = await GetStorage().read('token');

      final response = await http.delete(
        url,
        headers: {
          acceptHeader: jsonAcceptType,
          contentTypeHeader: jsonContentType,
          authorizationHeader: 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Shipping address deleted successfully');
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        debugPrint(errorMessage);
        throw Exception('Failed to delete shipping address');
      }
    } catch (e) {
      throw Exception('Failed to delete shipping address');
    }
  }
}
