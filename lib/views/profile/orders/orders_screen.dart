import 'package:batrina/controllers/cubit/admin/admin_mode/admin_mode_cubit.dart';
import 'package:batrina/controllers/cubit/profile/orders/orders_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/profile/orders/widgets/empty_orders.dart';
import 'package:batrina/views/profile/orders/widgets/order_item_card.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final initialAdminMode = context.read<AdminModeCubit>().state;
    return BlocProvider(
      create: (context) =>
          OrdersCubit()..fetchOrders(isAdmin: initialAdminMode),
      child: BlocListener<AdminModeCubit, bool>(
        listener: (context, isAdminMode) {
          context.read<OrdersCubit>().fetchOrders(isAdmin: isAdminMode);
        },
        child: Scaffold(
          appBar: AppBar(
            title: CustomHeaderWidget(
              center: BlocBuilder<AdminModeCubit, bool>(
                builder: (context, isAdminMode) {
                  return CustomText(
                    data: isAdminMode ? loc!.allOrdersAdmin : loc!.myOrders,
                    textAlign: TextAlign.center,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  );
                },
              ),
              prefix: const BackArrow(),
            ),
            leading: const SizedBox(),
            leadingWidth: 0,
          ),
          body: SafeArea(
            child: BlocBuilder<OrdersCubit, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                } else if (state is OrdersFailure) {
                  return Center(
                    child: CustomText(
                      data: state.errMessage,
                      fontSize: 14.sp,
                      color: Colors.red,
                    ),
                  );
                } else if (state is OrdersSuccess) {
                  if (state.orders.isEmpty) {
                    return const EmptyOrdersView();
                  }

                  final currentAdminMode = context
                      .watch<AdminModeCubit>()
                      .state;

                  return ListView.separated(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.h,
                      vertical: 16.h,
                    ),
                    itemCount: state.orders.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return OrderItemCard(
                        order: state.orders[index],
                        isAdminMode: currentAdminMode,
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
