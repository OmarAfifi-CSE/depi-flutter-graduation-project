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

  void removeLocal(String cartId) {
    for (var x in (state as GetWishListSuccess).userWishList) {
      print(x.id);
    }
    if (state is GetWishListSuccess) {
      List<WishlistModel> userWishList = List.from(
        (state as GetWishListSuccess).userWishList,
      )..removeWhere((element) => element.id == cartId);
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
}
