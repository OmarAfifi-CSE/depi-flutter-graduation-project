import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/product_model.dart';
import '../../../../models/review_model.dart';

part 'add_review_state.dart';

class AddReviewCubit extends Cubit<AddReviewState> {
  AddReviewCubit() : super(AddReviewInitial());
  FireBaseFireStore fireBaseFireStore=FireBaseFireStore();

  Future<void> addReview({
    required ReviewModel reviewModel,
    required ProductModel productModel,
  })async{
    try{
      emit(AddReviewLoading());
      await fireBaseFireStore.addReview(reviewModel: reviewModel, productModel: productModel);
      emit(AddReviewSuccess());
    }
    catch(e){
      emit(AddReviewFailure(error: "error happened"));
    }
  }
}
