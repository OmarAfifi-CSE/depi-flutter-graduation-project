import 'dart:async';

import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/order_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'order_details_state.dart';

class OrderDetailsCubit extends Cubit<OrderDetailsState> {
  final FireBaseFireStore _repo = FireBaseFireStore();
  StreamSubscription? _orderSubscription;

  OrderDetailsCubit() : super(OrderDetailsInitial());

  // دالة بتبدأ الاستماع
  void monitorOrder(OrderModel initialOrder) {
    // 1. اعرض الداتا المبدئية فوراً عشان الشاشة متبيضش
    emit(OrderDetailsSuccess(initialOrder));

    // 2. الغي أي اشتراك قديم
    _orderSubscription?.cancel();

    // 3. اشترك في التحديثات
    _orderSubscription = _repo
        .getOrderStream(initialOrder.id)
        .listen(
          (updatedOrder) {
            emit(OrderDetailsSuccess(updatedOrder));
          },
          onError: (error) {
            emit(OrderDetailsFailure(error.toString()));
          },
        );
  }

  // دالة تحديث الحالة (للأدمن)
  Future<void> updateStatus(String orderId, String newStatus) async {
    try {
      await _repo.updateOrderStatus(orderId, newStatus);
      // مش محتاجين emit لأن الستريم فوق هيحس بالتغيير ويحدث الـ UI
    } catch (e) {
      // ممكن تعرض سناك بار لو حصل مشكلة
      print(e.toString());
    }
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel(); // مهم جداً عشان الميموري
    return super.close();
  }
}
