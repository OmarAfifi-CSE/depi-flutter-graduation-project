part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class CartFailure extends CartState {
  final String error;

  CartFailure({required this.error});
}

final class AddToCartSuccess extends CartState {}

final class RemoveFromCartSuccess extends CartState {}

final class CartLoading extends CartState {}
