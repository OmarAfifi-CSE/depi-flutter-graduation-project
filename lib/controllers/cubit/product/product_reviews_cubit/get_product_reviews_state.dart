part of 'get_product_reviews_cubit.dart';

@immutable
sealed class GetProductReviewsState {}

final class GetProductReviewsInitial extends GetProductReviewsState {}

final class GetProductReviewsFailure extends GetProductReviewsState {
  final String error;

  GetProductReviewsFailure({required this.error});
}

final class GetProductReviewsSuccess extends GetProductReviewsState {
  final List<ReviewModel> reviews;

  GetProductReviewsSuccess({required this.reviews});
}

final class GetProductReviewsLoading extends GetProductReviewsState {}
