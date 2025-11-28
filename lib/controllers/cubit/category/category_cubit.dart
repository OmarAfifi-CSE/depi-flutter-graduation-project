import 'dart:async'; // 1. مهم عشان StreamSubscription

import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FireBaseFireStore _fireStoreService = FireBaseFireStore();
  StreamSubscription? _categoriesSubscription;
  List<CategoryModel> _allCategories = [];
  String _currentSearchQuery = '';

  CategoryCubit() : super(CategoryInitial());

  void fetchCategories({required bool isAdmin}) {
    emit(CategoryLoading());
    _categoriesSubscription?.cancel();
    _categoriesSubscription = _fireStoreService
        .getCategoriesStream(isAdmin)
        .listen(
          (categories) {
            _allCategories = categories;
            if (_currentSearchQuery.isNotEmpty) {
              _emitFilteredCategories();
            } else {
              emit(CategorySuccess(_allCategories));
            }
          },
          onError: (error) {
            emit(CategoryError(error.toString()));
          },
        );
  }

  void searchCategories(String query) {
    _currentSearchQuery = query;
    _emitFilteredCategories();
  }

  void _emitFilteredCategories() {
    if (_currentSearchQuery.isEmpty) {
      emit(CategorySuccess(_allCategories));
      return;
    }
    final filteredList = _allCategories.where((category) {
      return category.name.toLowerCase().contains(
        _currentSearchQuery.toLowerCase(),
      );
    }).toList();
    emit(CategorySuccess(filteredList));
  }

  void reorderLocally(int oldIndex, int newIndex) {
    if (state is CategorySuccess) {
      final currentList = List<CategoryModel>.from(
        (state as CategorySuccess).categories,
      );
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final item = currentList.removeAt(oldIndex);
      currentList.insert(newIndex, item);
      emit(CategorySuccess(currentList));
    }
  }

  Future<void> saveOrderToFirebase() async {
    if (state is CategorySuccess) {
      final currentList = (state as CategorySuccess).categories;

      List<CategoryModel> updatedCategories = [];
      for (int i = 0; i < currentList.length; i++) {
        updatedCategories.add(currentList[i].copyWith(rank: i));
      }
      _allCategories = updatedCategories;

      try {
        await _fireStoreService.updateCategoriesOrder(updatedCategories);
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    _categoriesSubscription?.cancel();
    return super.close();
  }
}
