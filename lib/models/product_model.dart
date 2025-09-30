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
  final double? rating;
  final int? reviewsCount;
  final String sellerId;
  final String sellerName;
  final double shippingCost;
  final bool freeShipping;
  final bool isActive;
  final bool isFeatured;
  final bool isOnSale;
  final bool isInStock;
  final List<ProductVariant> variants;
  final List<ProductColor> availableColors;

  // get it from variants better
  // final List<String> availableSizes;

  // ليه عاملهم ارراي علشان لو عملتهم subCollection هيبقي تقيل اوي علشان اجيب برودكت واحد
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
    required this.sellerId,
    required this.sellerName,
    this.shippingCost = 0.0,
    this.freeShipping = false,
    this.isActive = true,
    this.isFeatured = false,
    this.isOnSale = false,
    this.isInStock = true,
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
      sellerId: json['sellerId'] ?? '',
      sellerName: json['sellerName'] ?? '',
      shippingCost: (json['shippingCost'] ?? 0.0).toDouble(),
      freeShipping: json['freeShipping'] ?? false,
      isActive: json['isActive'] ?? true,
      isFeatured: json['isFeatured'] ?? false,
      isOnSale: json['isOnSale'] ?? false,
      isInStock: json['isInStock'] ?? true,
      variants: [],
      availableColors:
          (json['availableColors'] as List<dynamic>?)
              ?.map((c) => ProductColor.fromJson(c))
              .toList() ??
          [], // ← Fixed
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
          : null,
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
      'sellerId': sellerId,
      'sellerName': sellerName,
      'shippingCost': shippingCost,
      'freeShipping': freeShipping,
      'isActive': isActive,
      'isFeatured': isFeatured,
      'isOnSale': isOnSale,
      'isInStock': isInStock,

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
    String? subTitle,
    String? category,
    double? price,
    double? salePrice,
    String? thumbnail,
    double? rating,
    int? reviewsCount,
    String? sellerId,
    String? sellerName,
    double? shippingCost,
    bool? freeShipping,
    bool? isActive,
    bool? isFeatured,
    bool? isOnSale,
    bool? isInStock,
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
      subtitle: subTitle ?? this.subtitle,
      category: category ?? this.category,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      thumbnail: thumbnail ?? this.thumbnail,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      shippingCost: shippingCost ?? this.shippingCost,
      freeShipping: freeShipping ?? this.freeShipping,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
      isOnSale: isOnSale ?? this.isOnSale,
      isInStock: isInStock ?? this.isInStock,
      variants: variants ?? this.variants,
      availableColors: availableColors ?? this.availableColors,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  void printDetails() {
    print("=========== 🛍️ Product Details ===========");
    print("ID: $id");
    print("Name: $name");
    print("Description: $description");
    print("Category: $category");
    print("Price: $price");
    if (salePrice != null) print("Sale Price: $salePrice");
    print("Thumbnail: $thumbnail");
    print("Rating: $rating (${reviewsCount ?? 0} reviews)");
    print("Seller: $sellerName (ID: $sellerId)");
    print("Shipping Cost: $shippingCost | Free: $freeShipping");
    print(
      "Active: $isActive | Featured: $isFeatured | On Sale: $isOnSale | In Stock: $isInStock",
    );
    print("Created At: $createdAt | Updated At: $updatedAt");

    // ✅ اطبع الـ Colors
    if (availableColors.isNotEmpty) {
      print("Available Colors:");
      for (var color in availableColors) {
        print(
          " - ${color.name} (${color.colorCode}) | Available: ${color.isAvailable}",
        );
        if (color.images.isNotEmpty) {
          print("   Images: ${color.images.join(", ")}");
        }
      }
    }

    // ✅ اطبع الـ Variants
    if (variants.isNotEmpty) {
      print("Variants:");
      for (var v in variants) {
        print(
          " - ${v.displayName} | Stock: ${v.stock} | In Stock: ${v.inStock}",
        );
      }
    }

    // ✅ اطبع باقي البيانات المحسوبة
    print("Total Stock: $totalStock");
    print("Final Price: $finalPrice");
    print(
      "Has Discount: $hasDiscount | Discount %: ${discountPercentage.toStringAsFixed(1)}%",
    );
    print("Available Sizes: ${availableSizes.join(", ")}");
    print("=========================================");
  }
}

class ProductColor {
  final String name;
  final String colorCode; // '#F5F5F5', '#000000', '#FFFFFF'
  final List<String> images; // ← صور خاصة بالّلون ده
  final bool isAvailable;

  ProductColor({
    required this.name,
    required this.colorCode,
    this.images = const [],
    this.isAvailable = true,
  });

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      name: json['name'] ?? '',
      colorCode: json['colorCode'] ?? '#000000',
      images: List<String>.from(json['images'] ?? []),
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'colorCode': colorCode,
      'images': images,
      'isAvailable': isAvailable,
    };
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
    this.stock = 0,
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
      id: this.id,
      color: color ?? this.color,
      size: size ?? this.size,
      stock: stock ?? this.stock,
    );
  }

  bool get inStock => stock > 0;
  String get displayName => '$color - $size';
}
