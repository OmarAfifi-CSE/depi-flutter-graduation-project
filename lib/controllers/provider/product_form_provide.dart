import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:batrina/models/product_model.dart';

class ProductFormProvider extends ChangeNotifier {
  late ProductModel _product;
  late ProductModel _originalProduct;

  late TextEditingController name;

  late TextEditingController description;

  late TextEditingController subtitle;
  late TextEditingController price;
  String _selectedVariantType = 'Standard';
  bool addMode = false;

  final List<String> variantTypes = ['Clothing', 'Numeric', 'Standard'];
  final List<String> numericSizes = List.generate(
    29,
    (index) => (20 + index).toString(),
  );
  final List<String> clothingSizes = ['XS', 'S', 'M', 'L', 'XL', 'XXL', '3XL'];

  // --- Getters ---
  ProductModel get product => _product;
  String get selectedVariantType => _selectedVariantType;

  bool get hasChanges {
    final ProductModel currentData = _product.copyWith(
      name: name.text.trim(),
      description: description.text.trim(),
      subtitle: subtitle.text.trim(),
      price: double.tryParse(price.text) ?? 0.0,
    );

    if (_product.id.isEmpty) {
      return true;
    }

    return !_isSameProduct(currentData, _originalProduct);
  }

  bool _isSameProduct(ProductModel a, ProductModel b) {
    final Set<String> aVariants = a.variants
        .map((v) => "${v.color}-${v.size}-${v.stock}")
        .toSet();
    final Set<String> bVariants = b.variants
        .map((v) => "${v.color}-${v.size}-${v.stock}")
        .toSet();

    if (aVariants.length != bVariants.length ||
        !aVariants.containsAll(bVariants)) {
      return false;
    }

    final Map<String, dynamic> aMap = a.toJson();
    final Map<String, dynamic> bMap = b.toJson();

    for (var map in [aMap, bMap]) {
      map.remove('variants');
      map.remove('updatedAt');
      map.remove('createdAt');
    }
    return jsonEncode(aMap) == jsonEncode(bMap);
  }

  bool get isValid {
    return _product.name.trim().isNotEmpty &&
        _product.price > 0 &&
        _product.categoryName.isNotEmpty &&
        _product.availableColors.isNotEmpty &&
        _product.thumbnail.trim().isNotEmpty;
  }

  void setType(String type) {
    _selectedVariantType = type;
    notifyListeners();
  }

  List<String> get availableSizesForVariantType {
    switch (_selectedVariantType) {
      case 'Clothing':
        return clothingSizes;
      case 'Numeric':
        return numericSizes;
      default:
        return [];
    }
  }

  List<ProductVariant> getVariantsForColor(String colorCode) {
    return _product.variants
        .where((v) => v.color.toLowerCase() == colorCode.toLowerCase())
        .toList();
  }

  List<String> getAvailableSizesForColorVariant(String colorCode) {
    return getVariantsForColor(colorCode).map((v) => v.size).toSet().toList();
  }

  // ============================================================
  // 1. التهيئة
  // ============================================================
  void initProduct(ProductModel? productToEdit) {
    if (productToEdit != null) {
      _product = productToEdit.copyWith();
      name = TextEditingController(text: _product.name);

      description = TextEditingController(text: _product.description);

      subtitle = TextEditingController(text: _product.subtitle);
      price = TextEditingController(text: _product.price.toString());
      _detectVariantType();
    } else {
      _product = ProductModel(
        id: '',
        name: '',
        description: '',
        subtitle: '',
        categoryName: '',
        price: 0.0,
        thumbnail: '',
        variants: [],
        availableColors: [],
      );
      _selectedVariantType = 'Standard';
      name = TextEditingController();

      description = TextEditingController();

      subtitle = TextEditingController();
      price = TextEditingController();
    }
    _originalProduct = _product;
  }

  void _detectVariantType() {
    if (_product.variants.isEmpty) {
      _selectedVariantType = 'Standard';
      return;
    }

    final allClothing = _product.variants.every(
      (v) => clothingSizes.contains(v.size),
    );
    if (allClothing) {
      _selectedVariantType = 'Clothing';
      return;
    }

    final allNumeric = _product.variants.every(
      (v) => numericSizes.contains(v.size),
    );
    if (allNumeric) {
      _selectedVariantType = 'Numeric';
      return;
    }

    _selectedVariantType = 'Standard';
  }

  String detectProductType() {
    if (_product.variants.isEmpty) {
      return 'Not Selected';
    }

    final allClothing = _product.variants.every(
      (v) => clothingSizes.contains(v.size),
    );
    if (allClothing) {
      return 'Clothing';
    }

    final allNumeric = _product.variants.every(
      (v) => numericSizes.contains(v.size),
    );
    if (allNumeric) {
      return 'Numeric';
    }

    return 'Standard';
  }

  // ============================================================
  // 2. تحديث البيانات الأساسية (Setter Methods)
  // ============================================================

  void setName(String name) {
    _product = _product.copyWith(name: name);
    notifyListeners(); // عشان (hasChanges) تحس بالتغيير
  }

  void setDescription(String description) {
    _product = _product.copyWith(description: description);
    notifyListeners();
  }

  void setSubtitle(String subtitle) {
    _product = _product.copyWith(subtitle: subtitle);
    notifyListeners();
  }

  void setPrice(String priceStr) {
    // لو الرقم صح حوله، لو غلط (فاضي مثلاً) خليه 0
    double newPrice = double.tryParse(priceStr) ?? 0.0;

    _product = _product.copyWith(price: newPrice);
    notifyListeners();
  }

  void setThumbNail(String image) {
    _product = _product.copyWith(thumbnail: image);
    notifyListeners();
  }

  void setSalePrice(String salePriceStr) {
    if (salePriceStr.isEmpty) {
      // لو مسح الكلام، خلي الخصم null (مفيش خصم)
      _product = _product.copyWith(salePrice: null);
    } else {
      double? newSalePrice = double.tryParse(salePriceStr);
      // (ملاحظة: copyWith عندك بتقبل null، بس هنا لازم نتأكد إننا بنبعت القيمة صح)
      // بما إن copyWith في الموديل بتاعك بياخد القيمة، هنضطر نعمل تريكاية لو القيمة null
      // بس للتسهيل، هنفترض إن الموديل بيقبل التغيير ده:
      _product = _product.copyWith(salePrice: newSalePrice);
    }
    notifyListeners();
  }

  void setCategory(String categoryName) {
    _product = _product.copyWith(categoryName: categoryName);
    notifyListeners();
  }

  // ============================================================
  // 3. إدارة نوع الـ Variant
  // ============================================================
  void changeVariantType(String newType) {
    if (_selectedVariantType == newType) return;

    _selectedVariantType = newType;

    // ✅ نضف كل الـ variants القديمة لما نغير النوع
    _product = _product.copyWith(variants: []);

    notifyListeners();
  }

  void updateVariant(ProductVariant oldVariant, ProductVariant newVariant) {
    // 1. خد نسخة من الليستة الحالية
    List<ProductVariant> updatedVariants = List.from(_product.variants);

    final int index = updatedVariants.indexWhere(
      (v) =>
          v.color.toLowerCase() == oldVariant.color.toLowerCase() &&
          v.size.toLowerCase() == oldVariant.size.toLowerCase(),
    );

    if (index != -1) {
      final isDuplicate = updatedVariants.any(
        (v) =>
            v.color.toLowerCase() == newVariant.color.toLowerCase() &&
            v.size.toLowerCase() == newVariant.size.toLowerCase() &&
            // خلي بالك: ما تقارنش مع نفس الـ variant اللي بتعدله
            !(v.color.toLowerCase() == oldVariant.color.toLowerCase() &&
                v.size.toLowerCase() == oldVariant.size.toLowerCase()),
      );

      if (isDuplicate) {
        return;
      }

      updatedVariants[index] = ProductVariant(
        id: updatedVariants[index].id,
        color: newVariant.color,
        size: newVariant.size,
        stock: newVariant.stock,
      );

      _product = _product.copyWith(variants: updatedVariants);
      notifyListeners();
    }
  }

  void addVariantForColor(String colorCode, String sizeOrNumber, int stock) {
    final exists = _product.variants.any(
      (v) =>
          v.color.toLowerCase() == colorCode.toLowerCase() &&
          v.size.toLowerCase() == sizeOrNumber.toLowerCase(),
    );

    if (exists) {
      return;
    }

    List<ProductVariant> updatedVariants = List.from(_product.variants);

    updatedVariants.add(
      ProductVariant(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // unique ID
        color: colorCode,
        size: sizeOrNumber,
        stock: stock,
      ),
    );

    _product = _product.copyWith(variants: updatedVariants);
    notifyListeners();
  }

  void updateVariantStock(String colorCode, String sizeOrNumber, int newStock) {
    List<ProductVariant> updatedVariants = _product.variants.map((v) {
      if (v.color.toLowerCase() == colorCode.toLowerCase() &&
          v.size.toLowerCase() == sizeOrNumber.toLowerCase()) {
        return v.copyWith(stock: newStock);
      }
      return v;
    }).toList();

    _product = _product.copyWith(variants: updatedVariants);
    notifyListeners();
  }

  void removeVariant(String colorCode, String sizeOrNumber) {
    List<ProductVariant> updatedVariants = _product.variants
        .where(
          (v) =>
              !(v.color.toLowerCase() == colorCode.toLowerCase() &&
                  v.size.toLowerCase() == sizeOrNumber.toLowerCase()),
        )
        .toList();

    _product = _product.copyWith(variants: updatedVariants);
    notifyListeners();
  }

  void removeAllVariantsForColor(String colorCode) {
    List<ProductVariant> updatedVariants = _product.variants
        .where((v) => v.color.toLowerCase() != colorCode.toLowerCase())
        .toList();

    _product = _product.copyWith(variants: updatedVariants);
    notifyListeners();
  }

  void clearAllVariants() {
    _product = _product.copyWith(variants: []);
    notifyListeners();
  }

  // ============================================================
  // 5. إدارة الألوان (مع حذف الـ variants بتاعتها)
  // ============================================================

  void addProductColor(ProductColor newColor) {
    final bool exists = _product.availableColors.any(
      (element) => element.colorCode == newColor.colorCode,
    );

    if (exists) return;

    List<ProductColor> updatedColors = List.from(_product.availableColors);
    updatedColors.add(newColor);

    _product = _product.copyWith(availableColors: updatedColors);
    notifyListeners();
  }

  void updateProductColor(int colorIndex, ProductColor newProductColor) {
    List<ProductColor> updatedColors = List.from(_product.availableColors);

    if (newProductColor.images.isEmpty) {
      final String colorCodeToRemove = updatedColors[colorIndex].colorCode;
      removeAllVariantsForColor(colorCodeToRemove);

      updatedColors.removeAt(colorIndex);
    } else {
      updatedColors[colorIndex] = newProductColor;
    }
    _product = _product.copyWith(availableColors: updatedColors);
    notifyListeners();
  }

  void removeProductColor(int colorIndex) {
    final colorToRemove = _product.availableColors[colorIndex];

    // نحذف الـ variants بتاعة اللون ده
    removeAllVariantsForColor(colorToRemove.colorCode);

    // نحذف اللون نفسه
    List<ProductColor> updatedColors = List.from(_product.availableColors);
    updatedColors.removeAt(colorIndex);

    _product = _product.copyWith(availableColors: updatedColors);
    notifyListeners();
  }

  void reorderColors(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final List<ProductColor> currentColors = List.from(
      _product.availableColors,
    );
    final ProductColor item = currentColors.removeAt(oldIndex);
    currentColors.insert(newIndex, item);

    _product = _product.copyWith(availableColors: currentColors);
    notifyListeners();
  }

  // ============================================================
  // 6. إدارة الصور
  // ============================================================

  void addImageToColor(int colorIndex, String newImageUrl) {
    List<ProductColor> updatedColors = List.from(_product.availableColors);
    List<String> newImages = List.from(updatedColors[colorIndex].images);
    newImages.add(newImageUrl);

    updatedColors[colorIndex] = ProductColor(
      colorCode: updatedColors[colorIndex].colorCode,
      images: newImages,
    );

    _product = _product.copyWith(availableColors: updatedColors);
    notifyListeners();
  }

  void removeImageFromColor(int colorIndex, int imageIndex) {
    List<ProductColor> updatedColors = List.from(_product.availableColors);
    List<String> newImages = List.from(updatedColors[colorIndex].images);
    newImages.removeAt(imageIndex);

    updatedColors[colorIndex] = ProductColor(
      colorCode: updatedColors[colorIndex].colorCode,
      images: newImages,
    );

    _product = _product.copyWith(availableColors: updatedColors);
    notifyListeners();
  }
}
