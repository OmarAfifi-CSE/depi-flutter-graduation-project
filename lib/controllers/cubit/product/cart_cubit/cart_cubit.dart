import 'package:batrina/controllers/cubit/product/get_product_cubit/get_product_cubit.dart';
import 'package:batrina/controllers/cubit/product/get_user_cart_for_product_cubit/get_user_cart_for_product_cubit.dart';
import 'package:batrina/controllers/cubit/product/product_reviews_cubit/get_product_reviews_cubit.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  late BuildContext context;
  Future<void> addToCart({required CartModel cartModel}) async {
    try {
      emit(CartLoading());
      CartModel cartModelWithNewId = await fireBaseFireStore.addToCart(
        cartModel: cartModel,
      );
      context.read<GetUserCartForProductCubit>().addLocale(
        cartModel: cartModelWithNewId,
      );
      emit(AddToCartSuccess());
    } catch (e) {
      if (e.toString().contains("not_available")) {
        emit(CartFailure(error: "Not available"));
        context.read<GetProductCubit>().getProduct(
          productId: cartModel.productId,
        );
      } else {
        emit(CartFailure(error: "error happened"));
      }
    }
  }

  Future<void> removeFromCart({required String cartId}) async {
    try {
      emit(CartLoading());
      print("amr" + cartId);
      await fireBaseFireStore.removeFromCart(cartId: cartId);
      context.read<GetUserCartForProductCubit>().deleteLocale(cartId: cartId);
      emit(RemoveFromCartSuccess());
    } catch (e) {
      emit(CartFailure(error: "error happened"));
    }
  }
}
