import 'dart:convert';

/*

  The CategoriesResponse class represents the entire response object, while the CategoriesModel class represents each individual category object within the data list.

  The fromJson factory method in the CategoriesResponse class parses the JSON response string into a Map<String, dynamic> object, then creates a List<CategoriesModel> by mapping each element in the "data" key of the map to a CategoriesModel instance using the fromJson factory method in the CategoriesModel class.

  The toJson method in both the CategoriesResponse and CategoriesModel classes creates a Map<String, dynamic> representation of the objects, which can be encoded to a JSON string using json.encode().

*/

CategoriesResponse categoriesFromJson(String str) =>
    CategoriesResponse.fromJson(json.decode(str));

String categoriesToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
  CategoriesResponse({
    required this.data,
  });

  List<CategoriesModel> data;

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        data: List<CategoriesModel>.from(
          json["data"].map(
            (x) => CategoriesModel.fromJson(x),
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

class CategoriesModel {
  CategoriesModel({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
