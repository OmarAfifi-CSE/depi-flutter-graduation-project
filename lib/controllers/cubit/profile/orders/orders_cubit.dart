import 'dart:async';

import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/order_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final FireBaseFireStore _repo = FireBaseFireStore();
  StreamSubscription? _ordersSubscription;

  OrdersCubit() : super(OrdersInitial());

  void fetchOrders({required bool isAdmin}) {
    emit(OrdersLoading());
    _ordersSubscription?.cancel();

    Stream<List<OrderModel>> stream;
    if (isAdmin) {
      stream = _repo.getAllOrdersForAdmin();
    } else {
      stream = _repo.getUserOrders();
    }

    _ordersSubscription = stream.listen(
          (orders) {
        emit(OrdersSuccess(orders));
      },
      onError: (error) {
        emit(OrdersFailure(error.toString()));
      },
    );
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _repo.updateOrderStatus(orderId, newStatus);
    } catch (e) {
      print("Error updating status: $e");
    }
  }

  @override
  Future<void> close() {
    _ordersSubscription?.cancel();
    return super.close();
  }
}
