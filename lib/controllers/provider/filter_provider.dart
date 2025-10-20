import 'package:flutter/material.dart';

class FilterProvider with ChangeNotifier {
  Set<String> _selectedCategories = {'Dresses'};

  Set<String> get selectedCategories => _selectedCategories;

  RangeValues _priceRange = const RangeValues(0, 750);

  RangeValues get priceRange => _priceRange;

  String _selectedSort = 'descending';

  String get selectedSort => _selectedSort;

  int? _selectedRating;

  int? get rating => _selectedRating;

  final options = ['descending', 'ascending'];

  final categories = [
    'Dresses',
    'Jackets',
    'Jeans',
    'Shoes',
    'Bags',
    'Clothing',
    'Shorts',
    'Tops',
    'Sneakers',
    'Cots',
    'Lingeries',
  ];

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
