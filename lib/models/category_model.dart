class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool isActive;
  final DateTime? createdAt;
  final int rank;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isActive = true,
    this.createdAt,
    this.rank = 0,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    bool? isActive,
    DateTime? createdAt,
    int? rank,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rank: rank ?? this.rank
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? true,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      rank: json['rank'] ?? 9999,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'rank': rank,
    };
  }
}
