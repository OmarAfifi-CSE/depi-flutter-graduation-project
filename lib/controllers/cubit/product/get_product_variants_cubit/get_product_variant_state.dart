part of 'get_product_variant_cubit.dart';

@immutable
sealed class GetProductVariantState {}

final class GetProductVariantInitial extends GetProductVariantState {}

final class GetProductVariantLoading extends GetProductVariantState {}

final class GetProductVariantSuccess extends GetProductVariantState {}

final class GetProductVariantFailure extends GetProductVariantState {
  final String error;

  GetProductVariantFailure({required this.error});
}
