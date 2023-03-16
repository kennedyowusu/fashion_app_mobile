import 'package:fashion_app/model/user.dart';
import 'package:fashion_app/services/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  final userService = UserService();
  final user = UserModel().obs;
  final isLoading = false.obs;
  final box = GetStorage().read('token');

  @override
  void onInit() {
    super.onInit();
    if (box != null) {
      readUserData();
    }
  }

  Future<void> readUserData() async {
    try {
      isLoading.value = true;
      final box = GetStorage().read('token');
      if (box != null) {
        UserModel? userData = await UserService().getUserData(box);
        if (userData != null) {
          user.value = userData;
          debugPrint('User: ${user.value.name}');
        } else {
          debugPrint('Failed to load user data');
        }
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
