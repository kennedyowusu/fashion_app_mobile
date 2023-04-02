// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartResponse cartModelFromJson(String str) => CartResponse.fromJson(json.decode(str));

String cartModelToJson(CartResponse data) => json.encode(data.toJson());

class CartResponse {
  CartResponse({
    required this.data,
  });

  CartModel data;

  factory CartResponse.fromJson(Map<String, dynamic> json) => CartResponse(
        data: CartModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class CartModel {
  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.quantity,
    required this.userId,
    required this.productId,
  });

  int id;
  String name;
  String image;
  int price;
  int quantity;
  int userId;
  int productId;

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        userId: json["user_id"],
        productId: json["product_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "user_id": userId,
        "product_id": productId,
      };
}
