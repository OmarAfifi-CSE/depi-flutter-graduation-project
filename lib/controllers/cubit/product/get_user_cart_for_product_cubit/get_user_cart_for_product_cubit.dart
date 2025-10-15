import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_user_cart_for_product_state.dart';

class GetUserCartForProductCubit extends Cubit<GetUserCartForProductState> {
  GetUserCartForProductCubit() : super(GetUserCartForProductInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future<void> getUserCartForProduct({
    required ProductModel productModel,
  }) async {
    try {
      emit(GetUserCartForProductLoading());
      List<CartModel> userCartForProduct = await fireBaseFireStore
          .getUserCartForProduct(productModel: productModel);
      emit(
        GetUserCartForProductSuccess(userCartForProduct: userCartForProduct),
      );
    } catch (e) {
      emit(GetUserCartForProductFailure(error: "error happened"));
    }
  }

  void addLocale({required CartModel cartModel}) {
    List<CartModel> userCartForProduct = List.from(
      (state as GetUserCartForProductSuccess).userCartForProduct,
    )..add(cartModel);
    emit(GetUserCartForProductSuccess(userCartForProduct: userCartForProduct));
  }

  void deleteLocale({required String cartId}) {
    List<CartModel> userCartForProduct = List.from(
      (state as GetUserCartForProductSuccess).userCartForProduct,
    )..removeWhere((element) => element.id == cartId);
    emit(GetUserCartForProductSuccess(userCartForProduct: userCartForProduct));
  }
}
