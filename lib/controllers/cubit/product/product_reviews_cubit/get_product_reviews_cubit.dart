import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_product_reviews_state.dart';

class GetProductReviewsCubit extends Cubit<GetProductReviewsState> {
  GetProductReviewsCubit() : super(GetProductReviewsInitial());

  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> getReviews(ProductModel productModel) async {
    try {
      emit(GetProductReviewsLoading());
      List<ReviewModel> reviews = await fireBaseFireStore.getReviews(
        productModel: productModel,
      );
      emit(GetProductReviewsSuccess(reviews: reviews));
    } catch (e) {
      emit(GetProductReviewsFailure(error: "error happened"));
    }
  }
}
