part of 'delete_product_cubit.dart';

@immutable
sealed class DeleteProductState {}

final class DeleteProductInitial extends DeleteProductState {}

final class DeleteProductLoading extends DeleteProductState {}

final class DeleteProductSuccess extends DeleteProductState {}

final class DeleteProductFailure extends DeleteProductState {
  final String error;

  DeleteProductFailure({required this.error});
}
