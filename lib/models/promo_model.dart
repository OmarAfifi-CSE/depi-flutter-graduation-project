class PromoCodeModel {
  final String code;
  final double discountPercentage;
  final double? discountAmount;
  final String? description;
  final DateTime? expiryDate;

  PromoCodeModel({
    required this.code,
    required this.discountPercentage,
    this.discountAmount,
    this.description,
    this.expiryDate,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      code: json['code'] ?? '',
      discountPercentage: (json['discount_percentage'] ?? 0).toDouble(),
      discountAmount: json['discount_amount'] != null
          ? (json['discount_amount']).toDouble()
          : null,
      description: json['description'],
      expiryDate: json['expiry_date'] != null
          ? DateTime.parse(json['expiry_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'discount_percentage': discountPercentage,
      'discount_amount': discountAmount,
      'description': description,
      'expiry_date': expiryDate?.toIso8601String(),
    };
  }

  bool get isValid {
    if (expiryDate != null && DateTime.now().isAfter(expiryDate!)) {
      return false;
    }
    return true;
  }

  double calculateDiscount(double orderAmount) {
    if (discountAmount != null) {
      return discountAmount!;
    } else {
      return (orderAmount * discountPercentage) / 100;
    }
  }

  PromoCodeModel copyWith({
    String? code,
    double? discountPercentage,
    double? discountAmount,
    String? description,
    DateTime? expiryDate,
  }) {
    return PromoCodeModel(
      code: code ?? this.code,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      description: description ?? this.description,
      expiryDate: expiryDate ?? this.expiryDate,
    );
  }
}
