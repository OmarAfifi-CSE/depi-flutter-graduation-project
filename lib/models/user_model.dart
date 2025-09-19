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
}
