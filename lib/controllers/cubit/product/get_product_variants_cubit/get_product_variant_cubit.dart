import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_product_variant_state.dart';

class GetProductVariantCubit extends Cubit<GetProductVariantState> {
  GetProductVariantCubit() : super(GetProductVariantInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> getProductVariants({required ProductModel productModel}) async {
    try {
      emit(GetProductVariantLoading());
      await fireBaseFireStore.getProductVariants(productModel: productModel);
      emit(GetProductVariantSuccess());
    } catch (e) {
      emit(GetProductVariantFailure(error: "error happened"));
    }
  }
}
