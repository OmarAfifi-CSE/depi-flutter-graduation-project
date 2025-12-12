import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/wish_list_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_wish_list_state.dart';

class GetWishListCubit extends Cubit<GetWishListState> {
  GetWishListCubit() : super(GetWishListInitial());

  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> getWishList() async {
    try {
      emit(GetWishListLoading());
      List<WishlistModel> userWishList = await fireBaseFireStore.getWishList();
      emit(GetWishListSuccess(userWishList: userWishList));
    } catch (e) {
      emit(GetWishListFailure(error: "error happened"));
    }
  }

  void removeLocal(String wishListId) {
    if (state is GetWishListSuccess) {
      List<WishlistModel> userWishList = List.from(
        (state as GetWishListSuccess).userWishList,
      )..removeWhere((element) => element.id == wishListId);
      emit(GetWishListSuccess(userWishList: userWishList));
    }
  }

  void addLocal(WishlistModel cartModel) {
    if (state is GetWishListSuccess) {
      List<WishlistModel> userWishList = List.from(
        (state as GetWishListSuccess).userWishList,
      )..add(cartModel);
      emit(GetWishListSuccess(userWishList: userWishList));
    }
  }

  void updateLocal(WishlistModel updatedItem) {
    if (state is GetWishListSuccess) {
      List<WishlistModel> currentList = List.from(
        (state as GetWishListSuccess).userWishList,
      );

      int index = currentList.indexWhere(
        (element) => element.id == updatedItem.id,
      );

      if (index != -1) {
        currentList[index] = updatedItem;

        emit(GetWishListSuccess(userWishList: currentList));
      }
    }
  }
}
