import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? picture;

  UserModel({
    this.picture,
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      picture: json["picture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'picture': picture};
  }

  static const String lastUserKey = "lastUser";
  static Future<void> setUser(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      await sharedPreferences.setString(
        UserModel.lastUserKey,
        jsonEncode(user.toJson()),
      );
    } catch (e) {
      debugPrint("error while adding last user");
    }
  }
}
