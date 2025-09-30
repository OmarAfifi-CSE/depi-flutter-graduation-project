import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  ProductModel productModel;
  late int variantStock;
  late List<String> currentSliderImage;

  late String? currentColorName;
  late String? currentSize;

  // late double currentRating;
  // late int currentRatingCount;
  ProductProvider(this.productModel);

  void setVariantStock({
    required String? colorCode,
    required String? sizeName,
  }) {
    currentSize = sizeName;
    currentColorName = colorCode;
    variantStock = productModel.getVariantStock(
      colorCode ?? '',
      sizeName ?? '',
    );
    print(variantStock.toString());
    notifyListeners();
  }

  void setSliderImage(String colorCode) {
    currentSliderImage = productModel.getImagesByColor(colorCode);
    notifyListeners();
  }

  // void setRating(List<ReviewModel> reviews) {
  //   double totalRating = 0;
  //   for (var review in reviews) {
  //     totalRating += review.rating;
  //   }
  //   double averageRating = totalRating / reviews.length;
  //   averageRating = averageRating.clamp(0.0, 5.0);
  //   currentRating = averageRating.round().toDouble();
  //   currentRatingCount = reviews.length;
  //   notifyListeners();
  // }
}
