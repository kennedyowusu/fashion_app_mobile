// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

ProductResponse productFromJson(String str) => ProductResponse.fromJson(json.decode(str));

String productToJson(ProductResponse data) => json.encode(data.toJson());

class ProductResponse {
  ProductResponse({
    required this.data,
  });

  List<Product> data;

  factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        data: List<Product>.from(json["data"].map((product) => Product.fromJson(product))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((product) => product.toJson())),
      };
}

class Product {
  Product({
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
  String price;
  int stock;
  String image;
  Is isNew;
  Is isFeatured;
  Is isPopular;
  Category category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stock: json["stock"],
        image: json["image"],
        isNew: isValues.map[json["is_new"]]!,
        isFeatured: isValues.map[json["is_featured"]]!,
        isPopular: isValues.map[json["is_popular"]]!,
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stock": stock,
        "image": image,
        "is_new": isValues.reverse[isNew],
        "is_featured": isValues.reverse[isFeatured],
        "is_popular": isValues.reverse[isPopular],
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

enum Is { YES, NO }

final isValues = EnumValues({"no": Is.NO, "yes": Is.YES});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
