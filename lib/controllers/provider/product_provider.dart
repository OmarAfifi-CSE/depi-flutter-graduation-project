import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  ProductModel productModel;
  late int currentVariantStock;
  late List<String> currentSliderImage;
  late String? currentColorName;
  late String? currentSize;
  int currentQuantity = 1;
  bool preview = false;

  ProductProvider({required this.productModel});

  ProductVariant? get variant =>
      productModel.getVariant(currentColorName ?? '', currentSize ?? '');

  void initialize({String? color, String? size}) {
    // Debug print removed
    if (productModel.isVariantAvailable(color ?? "", size ?? "")) {
      currentColorName = color;
      currentSize = size;
    } else if (productModel.availableSizes.isNotEmpty &&
        productModel.availableColors.isNotEmpty &&
        productModel.availableSizes.any((element) {
          return element == size;
        }) &&
        productModel.availableColors.any((element) {
          return element.colorCode == color;
        })) {
      currentColorName = color;
      currentSize = size;
    } else {
      currentColorName = productModel.availableColors.isEmpty
          ? null
          : productModel.availableColors[0].colorCode;

      currentSize = productModel.availableSizes.isEmpty
          ? null
          : productModel.availableSizes[0];
    }

    setVariantStock(colorCode: currentColorName, sizeName: currentSize);
    setSliderImage(currentColorName ?? '');
  }

  void reInitialize(
    ProductModel newProductModel, {
    String? color,
    String? size,
  }) {
    productModel = newProductModel;
    if (newProductModel.isVariantAvailable(color ?? "", size ?? "")) {
      currentColorName = color;
      currentSize = size;
    } else if (productModel.availableSizes.isNotEmpty &&
        productModel.availableColors.isNotEmpty &&
        productModel.availableSizes.any((element) {
          return element == size;
        }) &&
        productModel.availableColors.any((element) {
          return element.colorCode == color;
        })) {
      currentColorName = color;
      currentSize = size;
    } else {
      currentColorName = newProductModel.availableColors.isEmpty
          ? null
          : newProductModel.availableColors[0].colorCode;

      currentSize = newProductModel.availableSizes.isEmpty
          ? null
          : newProductModel.availableSizes[0];
    }

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
