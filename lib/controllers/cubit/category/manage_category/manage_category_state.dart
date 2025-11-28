part of 'manage_category_cubit.dart';

@immutable
sealed class ManageCategoryState {}

final class ManageCategoryInitial extends ManageCategoryState {}

final class ManageCategoryUpdated extends ManageCategoryState {
  final String? name;
  final String? image;
  final bool isActive;
  final bool isEditMode;

  ManageCategoryUpdated({
    this.name,
    this.image,
    required this.isActive,
    required this.isEditMode,
  });
}

final class ManageCategoryLoading extends ManageCategoryState {}

final class ManageCategorySuccess extends ManageCategoryState {
  final String? message;

  ManageCategorySuccess({this.message});
}

final class ManageCategoryError extends ManageCategoryState {
  final String message;

  ManageCategoryError(this.message);
}
