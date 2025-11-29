import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  List<String> _categories = [];
  List<String> get categories => _categories;

  Future<void> fetchCategories() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .get();
    _categories = snapshot.docs
        .map((doc) {
          final data = doc.data();
          return data['name']?.toString() ?? '';
        })
        .where((name) => name.isNotEmpty)
        .toList();
    notifyListeners();
  }

  Set<String> _selectedCategories = {''};

  Set<String> get selectedCategories => _selectedCategories;

  RangeValues _priceRange = const RangeValues(0, 750);

  RangeValues get priceRange => _priceRange;

  String _selectedSort = 'descending';

  String get selectedSort => _selectedSort;

  int? _selectedRating;

  int? get rating => _selectedRating;

  final options = ['descending', 'ascending'];

  void toggleCategory(String category) {
    if (_selectedCategories.contains(category)) {
      _selectedCategories.remove(category);
    } else {
      _selectedCategories.add(category);
    }
    notifyListeners();
  }

  void setPriceRange(RangeValues priceRange) {
    _priceRange = priceRange;
    notifyListeners();
  }

  void setSort(String sort) {
    _selectedSort = sort;
    notifyListeners();
  }

  void setRating(int? stars) {
    _selectedRating = stars;
    notifyListeners();
  }
}
