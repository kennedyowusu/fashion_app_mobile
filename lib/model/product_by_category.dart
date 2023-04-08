// To parse this JSON data, do
//
//     final productByCategory = productByCategoryFromJson(jsonString);

import 'dart:convert';

ProductByCategoryResponse productByCategoryFromJson(String str) =>
    ProductByCategoryResponse.fromJson(
      json.decode(str),
    );

String productByCategoryToJson(ProductByCategoryResponse data) => json.encode(
      data.toJson(),
    );

class ProductByCategoryResponse {
  ProductByCategoryResponse({
    required this.data,
  });

  List<ProductModel> data;

  factory ProductByCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ProductByCategoryResponse(
        data: List<ProductModel>.from(
          json["data"].map(
            (x) => ProductModel.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(
          data.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.image,
    required this.isNew,
    required this.isFeatured,
    required this.isPopular,
    required this.category,
  });

  int id;
  String name;
  String description;
  double price;
  int stock;
  String image;
  String isNew;
  String isFeatured;
  String isPopular;
  Category category;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        isNew: json["is_new"],
        isFeatured: json["is_featured"],
        isPopular: json["is_popular"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image": image,
        "is_new": isNew,
        "is_featured": isFeatured,
        "is_popular": isPopular,
        "category": category.toJson(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
