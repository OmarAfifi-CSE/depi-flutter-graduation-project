import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_edit_product_state.dart';

class AddEditProductCubit extends Cubit<AddEditProductState> {
  AddEditProductCubit() : super(AddEditProductInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> addEditProduct(ProductModel productModel) async {
    try {
      emit(AddEditProductLoading());
      await fireBaseFireStore.addProduct(productModel);
      emit(AddEditProductSuccess());
    } catch (e) {
      emit(AddEditProductFailure(error: "error happened"));
    }
  }
}
