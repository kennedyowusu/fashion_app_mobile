import 'dart:convert';

import 'package:fashion_app/helper/api_exception.dart';
import 'package:fashion_app/model/shipping_address.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:fashion_app/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ShippingAddressService {
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String jsonContentType = 'application/json';
  static const String jsonAcceptType = 'application/json';

  final RxBool isLoading = false.obs;

  final GetStorage box = GetStorage();

  Future<ShippingAddressModelResponse> fetchShippingAddress() async {
    final url = Uri.parse(SHIPPING_ADDRESS_URL);

    try {
      isLoading(true);

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
        isLoading(false);
        final jsonResponse = jsonDecode(response.body)['data'] as List<dynamic>;

        final shippingAddress = jsonResponse
            .where((item) => item['user_id'] == userId)
            .map((item) => ShippingAddress.fromJson(item))
            .toList();

        debugPrint('Shipping Address: ${shippingAddress.toString()}');

        return ShippingAddressModelResponse(
          data: shippingAddress,
        );
      } else {
        isLoading(false);
        final errorMessage = jsonDecode(response.body)['message'];
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: const EdgeInsets.all(8),
          borderRadius: 8,
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ),
        );

        throw Exception(errorMessage);
      }
    } catch (e) {
      throw ApiException('Failed to fetch shipping address', null);
    } finally {
      // Hide loading indicator
      isLoading(false);
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
      isLoading(true);
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
        isLoading(false);
        final jsonResponse = jsonDecode(response.body);

        debugPrint(
          'Response data: ${jsonResponse['data'] ?? 'No data available'}',
        );

        if (jsonResponse['data'] != null &&
            jsonResponse['data']['id'] != null) {
          box.write('shippingAddress', jsonResponse['data']);
          box.write('shippingAddressId', jsonResponse['data']['id']);
        }

        if (box.read('shippingAddressId') == null) {
          // handle error
          debugPrint('Error: Shipping Address ID is null');
        } else {
          debugPrint('Shipping Address ID: ${jsonResponse['data']['id']}');
          debugPrint(
            "Saved Shipping Address ID: ${box.read('shippingAddressId')}",
          );
        }

        CustomSnackbar.show(
          'Success',
          'Shipping address created successfully',
          color: Colors.green,
        );

        debugPrint(jsonResponse.toString());
      } else {
        isLoading(false);
        CustomSnackbar.show(
          'Sorry',
          jsonDecode(response.body)['error'],
          color: Colors.red,
        );
        debugPrint(response.body);
        final errorMessage = jsonDecode(response.body)['error'];
        debugPrint(errorMessage);
      }
    } catch (e) {
      if (e is ApiException) {
        // handle ApiException with custom error message
        debugPrint('Error: ${e.message}');
      } else {
        // handle other exceptions
        debugPrint('Error: $e');
      }
    } finally {
      // Hide loading indicator
      isLoading(false);
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
      isLoading(true);
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
        isLoading(false);
        debugPrint('Shipping address deleted successfully');
      } else {
        isLoading(false);
        final errorMessage = jsonDecode(response.body)['message'];
        debugPrint(errorMessage);
        throw Exception('Failed to delete shipping address');
      }
    } catch (e) {
      throw Exception('Failed to delete shipping address');
    } finally {
      isLoading(false);
    }
  }

  bool hasShippingAddressForCurrentUser() {
    final shippingAddressId = box.read('shippingAddressId');
    final currentUserId = box.read('currentUserId');
    final savedAddressUserId = box.read('shippingAddressUserId');

    return shippingAddressId != null &&
        currentUserId != null &&
        savedAddressUserId == currentUserId;
  }
}
