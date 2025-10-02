import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsProvider with ChangeNotifier {
  final FireBaseFireStore _firestoreService = FireBaseFireStore();

  List<ProductModel> products = [];
  bool isLoading = false;
  bool hasMore = true; // هل لسه فيه منتجات تانية نجيبها؟
  DocumentSnapshot? _lastDocument;

  // دالة لجلب المنتجات (سواء أول مرة أو الصفحات التالية)
  Future<void> fetchProducts(String category) async {
    if (isLoading || !hasMore) return; // لو بنحمّل حاليًا أو المنتجات خلصت، منعملش حاجة

    isLoading = true;
    notifyListeners();

    final result = await _firestoreService.getProductsPaginated(
      category: category,
      lastDocument: _lastDocument,
    );

    final newProducts = result['products'] as List<ProductModel>;
    _lastDocument = result['lastDoc'] as DocumentSnapshot?;

    products.addAll(newProducts);

    // لو الدفعة الأخيرة اللي جت أقل من 20، يبقى دي آخر صفحة
    if (newProducts.length < 20) {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();
  }

  // دالة عشان نعمل ريفرش ونبدأ من الأول
  void refresh(String category) {
    products.clear();
    _lastDocument = null;
    hasMore = true;
    fetchProducts(category);
  }
}