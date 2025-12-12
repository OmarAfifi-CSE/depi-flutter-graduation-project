import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/order_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  final FireBaseFireStore _fireBaseFireStore = FireBaseFireStore();

  PlaceOrderCubit() : super(PlaceOrderInitial());

  Future<void> placeOrder({required OrderModel order}) async {
    emit(PlaceOrderLoading());
    try {
      await _fireBaseFireStore.placeOrder(order: order);
      emit(PlaceOrderSuccess());
    } catch (e) {
      emit(PlaceOrderFailure(e.toString()));
    }
  }
}
