import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FireBaseFireStore _fireStoreService = FireBaseFireStore();

  CategoryCubit() : super(CategoryInitial());
  List<CategoryModel> _categories = [];

  Future<void> fetchCategories({required bool isAdmin}) async {
    try {
      emit(CategoryLoading());
      _categories = await _fireStoreService.getCategories(isAdmin);
      emit(CategorySuccess(_categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }

  void searchCategories(String query) {
    if (query.isEmpty) {
      emit(CategorySuccess(_categories));
      return;
    }

    final filteredList = _categories.where((category) {
      return category.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(CategorySuccess(filteredList));
  }

  void reorderLocally(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _categories.removeAt(oldIndex);
    _categories.insert(newIndex, item);

    emit(CategorySuccess(_categories));
  }

  Future<void> saveOrderToFirebase() async {
    List<CategoryModel> updatedCategories = [];
    for (int i = 0; i < _categories.length; i++) {
      updatedCategories.add(_categories[i].copyWith(rank: i));
    }
    _categories = updatedCategories;

    try {
      await _fireStoreService.updateCategoriesOrder(_categories);
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
