import 'dart:convert';

// Represents a user object
class User {
  final String accessToken;
  final String tokenType;
  final UserClass user;

  // Constructor
  User({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  // Factory constructor to create User object from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      user: UserClass.fromJson(json["user"]),
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "user": user.toJson(),
      };
}

// Represents a user's details
class UserClass {
  final String name;
  final String email;
  final String location;
  final String address;
  final String phone;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  // Constructor
  UserClass({
    required this.name,
    required this.email,
    required this.location,
    required this.address,
    required this.phone,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  // Factory constructor to create UserClass object from JSON
  factory UserClass.fromJson(Map<String, dynamic> json) {
    return UserClass(
      name: json["name"],
      email: json["email"],
      location: json["location"],
      address: json["address"],
      phone: json["phone"],
      updatedAt: DateTime.tryParse(json["updated_at"]) ?? DateTime.now(),
      createdAt: DateTime.tryParse(json["created_at"]) ?? DateTime.now(),
      id: json["id"],
    );
  }

  // Convert UserClass object to JSON
  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "location": location,
        "address": address,
        "phone": phone,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

// Factory function to create User object from JSON string
User userFromJson(String str) => User.fromJson(json.decode(str));

// Convert User object to JSON string
String userToJson(User data) => json.encode(data.toJson());
