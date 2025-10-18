part of 'get_cart_cubit.dart';

@immutable
sealed class GetCartState {}

final class GetCartInitial extends GetCartState {}

final class GetCartLoading extends GetCartState {}

final class GetCartSuccess extends GetCartState {
  final List<CartModel> userCart;

  GetCartSuccess({required this.userCart});
}

final class GetCartFailure extends GetCartState {
  final String error;

  GetCartFailure({required this.error});
}
