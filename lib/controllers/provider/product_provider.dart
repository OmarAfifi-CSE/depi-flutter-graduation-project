import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider extends ChangeNotifier {
  ProductModel productModel;
  late int currentVariantStock;
  late List<String> currentSliderImage;

  late String? currentColorName;
  late String? currentSize;

  ProductProvider(this.productModel);

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
