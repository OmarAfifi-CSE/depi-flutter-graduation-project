import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

class WishlistModel {
  final String id;
  final String productId;
  final String productName;
  final String subtitle;
  final String categoryName;
  final double price;
  final String thumbnail;

  final String variantId;
  final String color;
  final String size;

  final DateTime? addedAt;
  final int availableStock;

  WishlistModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.subtitle,
    required this.categoryName,
    required this.price,
    required this.thumbnail,
    required this.variantId,
    required this.color,
    required this.size,
    required this.addedAt,
    required this.availableStock,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) {
    return WishlistModel(
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      subtitle: json['subtitle'] ?? '',
      categoryName: json['categoryName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      variantId: json['variantId'] ?? '',
      color: json['color'] ?? '',
      size: json['size'] ?? '',
      addedAt: (json['addedAt'] as Timestamp?)?.toDate(),
      availableStock: json['availableStock'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'subtitle': subtitle,
      'categoryName': categoryName,
      'price': price,
      'thumbnail': thumbnail,
      'variantId': variantId,
      'color': color,
      'size': size,
      'addedAt': FieldValue.serverTimestamp(),
      'availableStock': availableStock,
    };
  }

  WishlistModel copyWith({
    String? id,
    String? productId,
    String? productName,
    String? subtitle,
    String? categoryName,
    double? price,
    String? thumbnail,
    String? variantId,
    String? color,
    String? size,
    DateTime? addedAt,
  }) {
    return WishlistModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      subtitle: subtitle ?? this.subtitle,
      categoryName: categoryName ?? this.categoryName,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      variantId: variantId ?? this.variantId,
      color: color ?? this.color,
      size: size ?? this.size,
      addedAt: addedAt ?? this.addedAt,
      availableStock: availableStock,
    );
  }

  Color get colorWidget {
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF000000);
    }
  }
}
