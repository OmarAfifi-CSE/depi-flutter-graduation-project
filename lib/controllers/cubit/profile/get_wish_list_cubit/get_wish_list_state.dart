part of 'get_wish_list_cubit.dart';

@immutable
sealed class GetWishListState {}

final class GetWishListInitial extends GetWishListState {}

final class GetWishListLoading extends GetWishListState {}

final class GetWishListSuccess extends GetWishListState {
  final List<WishlistModel> userWishList;

  GetWishListSuccess({required this.userWishList});
}

final class GetWishListFailure extends GetWishListState {
  final String error;

  GetWishListFailure({required this.error});
}
