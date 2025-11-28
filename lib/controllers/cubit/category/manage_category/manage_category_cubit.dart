import 'dart:convert';
import 'dart:typed_data';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/category_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'manage_category_state.dart';

class ManageCategoryCubit extends Cubit<ManageCategoryState> {
  final FireBaseFireStore _fireStoreService = FireBaseFireStore();
  AppLocalizations? loc;
  String _id = '';
  String _name = '';
  String? _image;
  bool _isActive = true;
  bool _isEditMode = false;
  DateTime? _createdAt;

  String? _originalName;

  ManageCategoryCubit() : super(ManageCategoryInitial());

  void initForm(CategoryModel? category) {
    if (category != null) {
      _id = category.id;
      _name = category.name;
      _originalName = category.name;
      _image = category.image;
      _isActive = category.isActive;
      _createdAt = category.createdAt;
      _isEditMode = true;
    } else {
      _id = '';
      _name = '';
      _image = null;
      _originalName = null;
      _isActive = true;
      _createdAt = null;
      _isEditMode = false;
    }
    _emitUpdate();
  }

  void updateName(String name) {
    _name = name;
  }

  void toggleActive(bool value) {
    _isActive = value;
    _emitUpdate();
  }

  void removeImage() {
    _image = null;
    _emitUpdate();
  }

  Future<void> pickImage() async {
    final XFile? xFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
    );

    if (xFile != null) {
      Uint8List bytes = await xFile.readAsBytes();
      _image = base64Encode(bytes);
      _emitUpdate();
    }
  }

  void _emitUpdate() {
    emit(
      ManageCategoryUpdated(
        name: _name,
        image: _image,
        isActive: _isActive,
        isEditMode: _isEditMode,
      ),
    );
  }

  void setImageUrl(String url) {
    if (url.isNotEmpty) {
      _image = url;
      _emitUpdate();
    }
  }

  Future<void> submitCategory() async {
    if (_name.trim().isEmpty || _image == null) {
      emit(ManageCategoryError(loc!.fillAllFields));
      _emitUpdate();
      return;
    }

    emit(ManageCategoryLoading());

    try {
      final categoryModel = CategoryModel(
        id: _id,
        name: _name.trim(),
        image: _image!,
        isActive: _isActive,
        createdAt: _isEditMode ? _createdAt : DateTime.now(),
      );
      await _fireStoreService.addOrUpdateCategory(
        category: categoryModel,
        oldName: _isEditMode ? _originalName : null,
      );
      emit(ManageCategorySuccess(message: loc!.categorySavedSuccessfully));
    } catch (e) {
      emit(ManageCategoryError(e.toString()));
      _emitUpdate();
    }
  }

  Future<void> deleteCategory() async {
    if (_id.isEmpty) return;
    emit(ManageCategoryLoading());
    try {
      await _fireStoreService.deleteCategory(_id, _name);
      emit(ManageCategorySuccess(message: loc!.categoryDeletedSuccessfully));
    } catch (e) {
      emit(ManageCategoryError(e.toString()));
      _emitUpdate();
    }
  }
}
