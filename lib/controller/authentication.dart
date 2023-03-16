import 'dart:convert';
import 'dart:io';

import 'package:fashion_app/layout.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:fashion_app/views/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  late final RxString token = ''.obs;
  final GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    token.value = box.read('token') ?? '';
  }

// Register a new user with the server
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String location,
    required String address,
    required String phone,
  }) async {
    // Create a map of the user data
    final Map<String, String> data = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'location': location,
      'address': address,
      'phone': phone,
    };
    try {
      // Show loading indicator while waiting for response
      isLoading(true);

      // Send a POST request to the server to register the user
      final response = await http.post(
        Uri.parse(REGISTER_URL),
        headers: HEADERS,
        body: data,
      );
      if (response.statusCode == 200) {
        // Registration successful
        isLoading(false);

        // Parse the response body and extract the access token
        final responseData = json.decode(response.body);
        token.value = responseData['access_token'];

        // Save the access token to the local storage
        box.write('token', token.value);

        // Navigate to the main layout
        Get.offAll(() => const MainLayout());

        debugPrint('${responseData['message']}');
      } else {
        // Registration failed
        isLoading(false);
        final errorMessage = json.decode(response.body)['message'];
        debugPrint(errorMessage);

        // Show error message to the user using a snackbar
        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on SocketException {
      isLoading(false);
      debugPrint('Network Error');
      Get.snackbar('Error', 'Registration Failed');
    } catch (e) {
      isLoading(false);
      debugPrint(e.toString());
      Get.snackbar('Error', 'Registration Failed');
    } finally {
      // Hide loading indicator
      isLoading(false);
    }
  }

  /// Logs in a user with the given [email] and [password].
  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    try {
      isLoading(true);

      final response = await http.post(
        Uri.parse(LOGIN_URL),
        headers: HEADERS,
        body: data,
      );

      if (response.statusCode == 200) {
        isLoading(false);

        final responseData = json.decode(response.body);

        token.value = responseData['access_token'];
        box.write('token', token.value);

        Get.offAll(() => const MainLayout());

        Get.snackbar(
          'Success',
          '${responseData['message']}',
          snackPosition: SnackPosition.BOTTOM,
        );

        return true;
      } else {
        isLoading(false);

        final message = json.decode(response.body)['message'];

        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
        );

        return false;
      }
    } on SocketException catch (_) {
      isLoading(false);
      Get.snackbar(
        'Error',
        'No internet connection',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        'Error',
        'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<void> logoutUser() async {
    try {
      final response = await http.post(
        Uri.parse(LOGOUT_URL),
        headers: HEADERS,
      );
      if (response.statusCode == 200) {
        token.value = '';
        box.remove('token');
        await Get.offAll(() => const AuthSelector());
      } else {
        debugPrint('${json.decode(response.body)['message']}');
        Get.snackbar(
          'Error',
          '${json.decode(response.body)['message']}',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on SocketException catch (e) {
      debugPrint(e.toString());
      Get.snackbar(
        'Error',
        'Network error: Check your internet connection',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar('Error', 'Logout Failed');
    }
  }

}
