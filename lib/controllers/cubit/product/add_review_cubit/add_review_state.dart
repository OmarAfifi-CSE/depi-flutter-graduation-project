part of 'add_review_cubit.dart';

@immutable
sealed class AddReviewState {}

final class AddReviewInitial extends AddReviewState {}

final class AddReviewLoading extends AddReviewState {}

final class AddReviewSuccess extends AddReviewState {}

final class AddReviewFailure extends AddReviewState {
  final String error;

  AddReviewFailure({required this.error});
}
