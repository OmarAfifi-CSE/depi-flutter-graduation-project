class CartModel {
  // معرف فريد لكل item في السلة
  final String id;

  // بيانات المنتج اللي محتاجنها
  final String productId;
  final String productName;
  final double price;
  final double? salePrice;

  // الاختيارات اللي المستخدم عملها
  final String selectedColor; // hex code زي '#000000'
  final List<String> selectedColorImages; // صور اللون المختار
  final String selectedSize; // المقاس المختار زي 'L'
  final int quantity; // الكمية

  // معلومات الـ variant
  final String variantId; // معرف الـ variant
  final int maxStock; // المخزون المتاح

  CartModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.price,
    this.salePrice,
    required this.selectedColor,
    required this.selectedColorImages,
    required this.selectedSize,
    required this.quantity,
    required this.variantId,
    required this.maxStock,
  });

  // الصورة الرئيسية (أول صورة من صور اللون)
  String get mainImage =>
      selectedColorImages.isNotEmpty ? selectedColorImages.first : '';

  // السعر النهائي للقطعة الواحدة
  double get finalPrice => salePrice ?? price;

  // إجمالي السعر قبل الخصم
  double get subtotal => price * quantity;

  // إجمالي الخصم
  double get discount {
    if (salePrice != null && salePrice! < price) {
      return (price - salePrice!) * quantity;
    }
    return 0.0;
  }

  // إجمالي السعر النهائي
  double get total => finalPrice * quantity;

  // تشيك لو الكمية وصلت للحد الأقصى من المخزون
  bool get isMaxQuantity => quantity >= maxStock;

  // تشيك لو فيه خصم
  bool get hasDiscount => salePrice != null && salePrice! < price;

  // نسبة الخصم
  double get discountPercentage {
    if (!hasDiscount) return 0.0;
    return ((price - salePrice!) / price * 100);
  }

  // تشيك لو متاح في المخزون
  bool get isInStock => maxStock > 0 && quantity <= maxStock;

  // JSON methods
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      productId: json['productId'] ?? '',
      productName: json['productName'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      salePrice: json['salePrice'] != null
          ? (json['salePrice']).toDouble()
          : null,
      selectedColor: json['selectedColor'] ?? '#000000',
      selectedColorImages: List<String>.from(json['selectedColorImages'] ?? []),
      selectedSize: json['selectedSize'] ?? '',
      quantity: json['quantity'] ?? 1,
      variantId: json['variantId'] ?? '',
      maxStock: json['maxStock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'price': price,
      'salePrice': salePrice,
      'selectedColor': selectedColor,
      'selectedColorImages': selectedColorImages,
      'selectedSize': selectedSize,
      'quantity': quantity,
      'variantId': variantId,
      'maxStock': maxStock,
    };
  }

  CartModel copyWith({
    String? id,
    String? productId,
    String? productName,
    double? price,
    double? salePrice,
    String? selectedColor,
    List<String>? selectedColorImages,
    String? selectedSize,
    int? quantity,
    String? variantId,
    int? maxStock,
  }) {
    return CartModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      salePrice: salePrice ?? this.salePrice,
      selectedColor: selectedColor ?? this.selectedColor,
      selectedColorImages: selectedColorImages ?? this.selectedColorImages,
      selectedSize: selectedSize ?? this.selectedSize,
      quantity: quantity ?? this.quantity,
      variantId: variantId ?? this.variantId,
      maxStock: maxStock ?? this.maxStock,
    );
  }
}
