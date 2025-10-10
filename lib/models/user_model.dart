class UserModel {
  final String id;
  final String role;
  final String name;
  final String email;
  final String? picture;
  String? mainAddressId;

  UserModel({
    this.picture,
    this.mainAddressId,
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
      mainAddressId: json['mainAddressId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'name': name,
      'email': email,
      'picture': picture,
      'mainAddressId': mainAddressId,
    };
  }
}
