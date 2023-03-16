import 'dart:convert';

import 'package:fashion_app/model/user.dart';
import 'package:fashion_app/services/endpoints.dart';
import 'package:http/http.dart' as http;

class UserService {

  Future<UserModel?> getUserData(String token) async {
    try {
      final response = await http.get(
        Uri.parse(USER_URL),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body ?? '');
        UserModel userData = UserModel.fromJson(jsonResponse);
        return userData;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception('Failed to load user data: $e');
    }
  }
  
}
