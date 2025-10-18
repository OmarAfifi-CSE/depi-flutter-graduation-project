import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FireBaseFireStore _fireStoreService = FireBaseFireStore();
  CategoryCubit() : super(CategoryInitial());
  List<CategoryModel> _categories = [];

  Future<void> fetchCategories() async {
    try {
      emit(CategoryLoading());
      _categories = await _fireStoreService.getCategories();
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
}
