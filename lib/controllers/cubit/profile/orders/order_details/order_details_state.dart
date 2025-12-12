part of 'order_details_cubit.dart';

@immutable
sealed class OrderDetailsState {}

final class OrderDetailsInitial extends OrderDetailsState {}

final class OrderDetailsSuccess extends OrderDetailsState {
  final OrderModel order;

  OrderDetailsSuccess(this.order);
}

final class OrderDetailsFailure extends OrderDetailsState {
  final String errMessage;

  OrderDetailsFailure(this.errMessage);
}
