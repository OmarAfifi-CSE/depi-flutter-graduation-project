import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String id;
  final String role;
  final String name;
  final String email;
  final String? picture;

  UserModel({
    this.picture,
    required this.id,
    required this.role,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      role: json['role'] ?? "user",
      name: json['name'],
      email: json['email'],
      picture: json["picture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'email': email,
      'picture': picture,
    };
  }
}
