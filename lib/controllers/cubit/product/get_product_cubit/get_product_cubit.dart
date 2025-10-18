import 'package:batrina/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:batrina/firebase/fire_base_firestore.dart';

part 'get_product_state.dart';

class GetProductCubit extends Cubit<GetProductState> {
  GetProductCubit() : super(GetProductInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> getProduct({required String productId}) async {
    try {
      emit(GetProductLoading());
      ProductModel? productModel = await fireBaseFireStore
          .getProductWithVariants(productID: productId);
      emit(GetProductSuccess(productModel: productModel));
    } catch (e) {
      emit(GetProductFailure(error: "error happened"));
    }
  }
}
