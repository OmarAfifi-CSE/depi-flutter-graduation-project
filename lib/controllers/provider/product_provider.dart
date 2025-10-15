import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  final ProductModel productModel;
  late int currentVariantStock;
  late List<String> currentSliderImage;
  late String? currentColorName;
  late String? currentSize;
  int quantity = 1;

  ProductProvider({required this.productModel});

  ProductVariant? get variant =>
      productModel.getVariant(currentColorName ?? '', currentSize ?? '');

  void initialize() {
    currentColorName = productModel.availableColors.isEmpty
        ? null
        : productModel.availableColors[0].colorCode;

    currentSize = productModel.availableSizes.isEmpty
        ? null
        : productModel.availableSizes[0];

    setVariantStock(colorCode: currentColorName, sizeName: currentSize);
    setSliderImage(currentColorName ?? '');
  }

  void updateRating(List<ReviewModel> reviews) {
    if (reviews.isEmpty) {
      productModel.rating = 0.0;
      productModel.reviewsCount = 0;
      notifyListeners();
      return;
    }

    double totalRating = 0;
    for (var review in reviews) {
      totalRating += review.rating;
    }
    double averageRating = totalRating / reviews.length;

    productModel.rating = averageRating.clamp(0.0, 5.0);
    productModel.reviewsCount = reviews.length;
    notifyListeners();
  }

  void setVariantStock({
    required String? colorCode,
    required String? sizeName,
  }) {
    currentSize = sizeName;
    currentColorName = colorCode;
    currentVariantStock = productModel.getVariantStock(
      colorCode ?? '',
      sizeName ?? '',
    );
    notifyListeners();
  }

  void setSliderImage(String colorCode) {
    currentSliderImage = productModel.getImagesByColor(colorCode);
    notifyListeners();
  }
}
