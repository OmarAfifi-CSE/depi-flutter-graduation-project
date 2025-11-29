import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'delete_product_state.dart';

class DeleteProductCubit extends Cubit<DeleteProductState> {
  DeleteProductCubit() : super(DeleteProductInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> deleteProduct(String pId) async {
    try {
      emit(DeleteProductLoading());
      await fireBaseFireStore.deleteProduct(pId);
      emit(DeleteProductSuccess());
    } catch (e) {
      emit(DeleteProductFailure(error: 'error happened'));
    }
  }
}
