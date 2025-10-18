import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'remove_from_cart_state.dart';

class RemoveFromCartCubit extends Cubit<RemoveFromCartState> {
  RemoveFromCartCubit() : super(RemoveFromCartInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  late BuildContext context;

  Future<void> removeFromCart(String cartId) async {
    try {
      emit(RemoveFromCartLoading());
      await fireBaseFireStore.removeFromCart(cartId: cartId);
      emit(RemoveFromCartSuccess());
    } catch (e) {
      emit(RemoveFromCartFailure(error: "error happened"));
    }
  }
}
