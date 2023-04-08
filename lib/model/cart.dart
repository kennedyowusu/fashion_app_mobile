import 'dart:convert';

CartResponse cartModelFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

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
    required this.totalPrice,
    required this.quantity,
    required this.userId,
    required this.productId,
  });

  int id;
  String name;
  String image;
  double price;
  double totalPrice;
  int quantity;
  int userId;
  int productId;

  // Define copyWith method
  CartModel copyWith({
    int? id,
    String? name,
    String? image,
    double? price,
    int? quantity,
    int? userId,
    int? productId,
    double? totalPrice,
  }) {
    return CartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      name: json["name"],
      image: json["image"],
      price: json["price"].toDouble(),
      quantity: json["quantity"] is int
          ? json["quantity"]
          : int.parse(json["quantity"]),
      userId: json["user_id"],
      productId: json["product_id"],
      totalPrice: json["total_price"].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "user_id": userId,
        "product_id": productId,
        "total_price": totalPrice,
      };
}
