import 'dart:ui';

class CartModel {
  final String id; // ← ID الـ Cart Item
  final String productId;
  final String productName;
  final String subtitle;

  final String variantId; // ← ID الـ Variant
  final String color; // اللون (hex)
  final String size; // الحجم
  final double price;
  final String thumbnail;
  int quantity; // ← الكمية
  final DateTime addedAt;

  CartModel({
    required this.subtitle,
    required this.id,
    required this.productId,
    required this.productName,
    required this.variantId,
    required this.color,
    required this.size,
    required this.price,
    required this.thumbnail,
    this.quantity = 1,
    required this.addedAt,
  });

  // Total price للـ item ده
  double get totalPrice => price * quantity;

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      subtitle: json['subtitle'],
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      variantId: json['variantId'] ?? '',
      color: json['color'] ?? '',
      size: json['size'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
      quantity: json['quantity'] ?? 1,
      addedAt: DateTime.tryParse(json['addedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'subtitle': subtitle,
      'variantId': variantId,
      'color': color,
      'size': size,
      'price': price,
      'thumbnail': thumbnail,
      'quantity': quantity,
      'addedAt': addedAt.toIso8601String(),
    };
  }

  CartModel copyWith({
    String? id,
    String? productId,
    String? productName,
    String? subtitle,
    String? variantId,
    String? color,
    String? size,
    double? price,
    String? thumbnail,
    int? quantity,
    DateTime? addedAt,
  }) {
    return CartModel(
      subtitle: subtitle ?? this.subtitle,
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      variantId: variantId ?? this.variantId,
      color: color ?? this.color,
      size: size ?? this.size,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      quantity: quantity ?? this.quantity,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  Color get colorWidget {
    try {
      return Color(int.parse(color.replaceFirst('#', '0xFF')));
    } catch (e) {
      return const Color(0xFF000000); // fallback color
    }
  }
}
