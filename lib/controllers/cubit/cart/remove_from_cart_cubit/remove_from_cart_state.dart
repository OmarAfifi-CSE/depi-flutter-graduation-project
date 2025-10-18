part of 'remove_from_cart_cubit.dart';

@immutable
sealed class RemoveFromCartState {}

final class RemoveFromCartInitial extends RemoveFromCartState {}

final class RemoveFromCartLoading extends RemoveFromCartState {}

final class RemoveFromCartSuccess extends RemoveFromCartState {}

final class RemoveFromCartFailure extends RemoveFromCartState {
  final String error;

  RemoveFromCartFailure({required this.error});
}
