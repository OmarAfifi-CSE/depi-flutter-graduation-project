part of 'get_user_cart_for_product_cubit.dart';

@immutable
sealed class GetUserCartForProductState {}

final class GetUserCartForProductInitial extends GetUserCartForProductState {}

final class GetUserCartForProductLoading extends GetUserCartForProductState {}

final class GetUserCartForProductSuccess extends GetUserCartForProductState {
  final List<CartModel> userCartForProduct;

  GetUserCartForProductSuccess({required this.userCartForProduct});
}

final class GetUserCartForProductFailure extends GetUserCartForProductState {
  final String error;

  GetUserCartForProductFailure({required this.error});
}
