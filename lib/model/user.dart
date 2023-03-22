// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

UserResponse userFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    required this.data,
  });

  UserModel data;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        data: UserModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.location,
    this.address,
    this.phone,
  });

  int? id;
  String? name;
  String? email;
  dynamic image;
  String? location;
  String? address;
  String? phone;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        location: json["location"],
        address: json["address"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "location": location,
        "address": address,
        "phone": phone,
      };
}
