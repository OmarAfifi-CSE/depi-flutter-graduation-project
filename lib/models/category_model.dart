class CategoryModel {
  final String name;
  final String image;
  final bool isActive;
  final DateTime? createdAt;

  CategoryModel({
    required this.name,
    required this.image,
    this.isActive = true,
    this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
