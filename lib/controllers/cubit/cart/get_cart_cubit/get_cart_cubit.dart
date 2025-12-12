import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_cart_state.dart';

class GetCartCubit extends Cubit<GetCartState> {
  GetCartCubit() : super(GetCartInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> getCart() async {
    try {
      emit(GetCartLoading());
      List<CartModel> userCart = await fireBaseFireStore.getUserCart();
      emit(GetCartSuccess(userCart: userCart));
    } catch (e) {
      emit(GetCartFailure(error: "An error occurred while fetching the cart."));
    }
  }

  void removeLocal(String cartId) {
    if (state is GetCartSuccess) {
      List<CartModel> userCart = List.from((state as GetCartSuccess).userCart)
        ..removeWhere((element) => element.id == cartId);
      emit(GetCartSuccess(userCart: userCart));
    }
  }

  void addLocal(CartModel cartModel) {
    if (state is GetCartSuccess) {
      List<CartModel> userCart = List.from((state as GetCartSuccess).userCart)
        ..add(cartModel);
      emit(GetCartSuccess(userCart: userCart));
    }
  }

  void updateLocal(CartModel updatedItem) {
    if (state is GetCartSuccess) {
      List<CartModel> currentList = List.from(
        (state as GetCartSuccess).userCart,
      );
      int index = currentList.indexWhere(
        (element) => element.id == updatedItem.id,
      );
      if (index != -1) {
        currentList[index] = updatedItem;
        emit(GetCartSuccess(userCart: currentList));
      }
    }
  }

  void clearCartLocal() {
    emit(GetCartSuccess(userCart: []));
  }
}
