part of 'get_product_cubit.dart';

@immutable
sealed class GetProductState {}

final class GetProductInitial extends GetProductState {}

final class GetProductFailure extends GetProductState {
  final String error;

  GetProductFailure({required this.error});
}

final class GetProductLoading extends GetProductState {}

final class GetProductSuccess extends GetProductState {
  final ProductModel? productModel;

  GetProductSuccess({required this.productModel});
}
