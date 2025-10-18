import 'dart:ui';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String subtitle;
  final String category;
  final double price;
  final double? salePrice;
  final String thumbnail;
  double? rating;
  int? reviewsCount;

  final bool isActive;
  final List<ProductVariant> variants;
  final List<ProductColor> availableColors;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.subtitle,
    required this.category,
    required this.price,
    this.salePrice,
    required this.thumbnail,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.isActive = true,

    required this.variants,
    this.availableColors = const [],
    this.createdAt,
    this.updatedAt,
  });

  List<String> get availableSizes {
    return variants
        .where((v) => v.stock > 0) // بس الأحجام اللي في ستوك
        .map((v) => v.size)
        .toSet() // علشان ميكررش
        .toList();
  }

  // جيب صور لون معين
  // جيب صور لون معين (بالـ hex code)
  List<String> getImagesByColor(String colorCode) {
    try {
      final color = availableColors.firstWhere(
        (c) => c.colorCode.toLowerCase() == colorCode.toLowerCase(),
      );
      return color.images.isNotEmpty ? color.images : [thumbnail];
    } catch (e) {
      return [thumbnail];
    }
  }

  // جيب الصورة الرئيسية للون معين (بالـ hex code)
  String getMainImageByColor(String colorCode) {
    final colorImages = getImagesByColor(colorCode);
    return colorImages.isNotEmpty ? colorImages.first : thumbnail;
  }

  // تشيك لو اللون والحجم متاحين (بالـ hex code)
  bool isVariantAvailable(String colorCode, String sizeName) {
    return variants.any(
      (v) =>
          v.color.toLowerCase() == colorCode.toLowerCase() &&
          v.size.toLowerCase() == sizeName.toLowerCase() &&
          v.stock > 0,
    );
  }

  // جيب الـ variant حسب الـ hex والحجم
  ProductVariant? getVariant(String colorCode, String sizeName) {
    try {
      return variants.firstWhere(
        (v) =>
            v.color.toLowerCase() == colorCode.toLowerCase() &&
            v.size.toLowerCase() == sizeName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  // جيب المخزون للـ variant معين
  int getVariantStock(String colorCode, String sizeName) {
    final variant = getVariant(colorCode, sizeName);
    return variant?.stock ?? 0;
  }

  // جيب الأحجام المتاحة للون معين (بالـ hex code)
  List<String> getAvailableSizesForColor(String colorCode) {
    return variants
        .where(
          (v) =>
              v.color.toLowerCase() == colorCode.toLowerCase() && v.stock > 0,
        )
        .map((v) => v.size)
        .toSet()
        .toList();
  }

  // جيب الألوان المتاحة للحجم معين
  List<ProductColor> getAvailableColorsForSize(String sizeName) {
    final availableColorCodes = variants
        .where(
          (v) => v.size.toLowerCase() == sizeName.toLowerCase() && v.stock > 0,
        )
        .map((v) => v.color)
        .toSet()
        .toList();

    return availableColors
        .where((color) => availableColorCodes.contains(color.colorCode))
        .toList();
  }

  int get totalStock {
    if (variants.isEmpty) return 0;
    return variants.fold(0, (total, variant) => total + variant.stock);
  }

  bool get inStock => totalStock > 0;
  double get finalPrice => salePrice ?? price;
  bool get hasDiscount => salePrice != null && salePrice! < price;

  double get discountPercentage {
    if (!hasDiscount) return 0.0;
    return ((price - salePrice!) / price * 100);
  }

  // JSON methods
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      subtitle: json['subtitle'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      salePrice: json['salePrice'] != null
          ? (json['salePrice']).toDouble()
          : null,
      thumbnail: json['thumbnail'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      isActive: json['isActive'] ?? true,
      variants: [],
      availableColors:
          (json['availableColors'] as List<dynamic>?)
              ?.map((c) => ProductColor.fromJson(c))
              .toList() ??
          [], // ← Fixed
      createdAt: DateTime.tryParse(json['createdAt'] ?? ""),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'subtitle': subtitle,
      'price': price,
      'salePrice': salePrice,
      'thumbnail': thumbnail,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'isActive': isActive,
      'availableColors': availableColors.map((c) => c.toJson()).toList(),
      'availableSizes': availableSizes, // ← Already strings
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? subtitle,
    String? category,
    double? price,
    double? salePrice,
    String? thumbnail,
    double? rating,
    int? reviewsCount,
    bool? isActive,
    List<ProductVariant>? variants,
    List<ProductColor>? availableColors,
    List<String>? availableSizes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      subtitle: subtitle ?? this.subtitle,
      category: category ?? this.category,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      thumbnail: thumbnail ?? this.thumbnail,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isActive: isActive ?? this.isActive,
      variants: variants ?? this.variants,
      availableColors: availableColors ?? this.availableColors,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ProductColor {
  final String colorCode; // '#F5F5F5', '#000000', '#FFFFFF'
  final List<String> images; // ← صور خاصة بالّلون ده

  ProductColor({required this.colorCode, this.images = const []});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      colorCode: json['colorCode'] ?? '#000000',
      images: List<String>.from(json['images'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'colorCode': colorCode, 'images': images};
  }

  // تحويل colorCode إلى Color للـ UI
  Color get color {
    try {
      return Color(int.parse(colorCode.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF000000); // fallback color
    }
  }
}

class ProductVariant {
  final String id;
  final String color; // اسم اللون
  final String size; // اسم الحجم
  final int stock;

  ProductVariant({
    required this.id,
    required this.color,
    required this.size,
    this.stock = 1,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    return ProductVariant(
      id: json['id'] ?? '',
      color: json['color'] ?? '',
      size: json['size'] ?? '',
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'color': color, 'size': size, 'stock': stock, "id": id};
  }

  ProductVariant copyWith({String? color, String? size, int? stock}) {
    return ProductVariant(
      id: id,
      color: color ?? this.color,
      size: size ?? this.size,
      stock: stock ?? this.stock,
    );
  }

  bool get inStock => stock > 0;
}
