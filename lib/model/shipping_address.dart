// To parse this JSON data, do
//
//     final shippingAddressModel = shippingAddressModelFromJson(jsonString);

import 'dart:convert';

ShippingAddressModelResponse shippingAddressModelFromJson(String str) =>
    ShippingAddressModelResponse.fromJson(json.decode(str));

String shippingAddressModelToJson(ShippingAddressModelResponse data) =>
    json.encode(data.toJson());

class ShippingAddressModelResponse {
  ShippingAddressModelResponse({
    required this.data,
  });

  List<ShippingAddress> data;

  factory ShippingAddressModelResponse.fromJson(Map<String, dynamic> json) =>
      ShippingAddressModelResponse(
        data: List<ShippingAddress>.from(
            json["data"].map((x) => ShippingAddress.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ShippingAddress {
  ShippingAddress({
    required this.id,
    required this.name,
    required this.addressLine1,
    this.addressLine2,
    required this.phone,
    required this.city,
    required this.state,
    required this.zip,
    required this.userId,
  });

  int id;
  String name;
  String addressLine1;
  dynamic addressLine2;
  String phone;
  String city;
  String state;
  String zip;
  int userId;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        id: json["id"],
        name: json["name"],
        addressLine1: json["address_line_1"],
        addressLine2: json["address_line_2"],
        phone: json["phone"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address_line_1": addressLine1,
        "address_line_2": addressLine2,
        "phone": phone,
        "city": city,
        "state": state,
        "zip": zip,
        "user_id": userId,
      };
}
