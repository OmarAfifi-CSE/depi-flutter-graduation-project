import 'package:batrina/controllers/cubit/admin/admin_mode/admin_mode_cubit.dart';
import 'package:batrina/controllers/cubit/profile/orders/orders_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/order_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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
                    data: isAdminMode ? "All Orders (Admin)" : loc!.myOrders,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                      return _buildEmptyOrdersState(loc); // Pass loc
                    }

                    final currentAdminMode = context
                        .watch<AdminModeCubit>()
                        .state;

                    return ListView.separated(
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
      ),
    );
  }

  Widget _buildEmptyOrdersState(AppLocalizations? loc) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_bag_outlined, size: 60.sp, color: Colors.grey),
          SizedBox(height: 10.h),
          CustomText(
            data: "No orders yet", // Use localized string if available
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

// --- Order Item Card Widget ---
class OrderItemCard extends StatelessWidget {
  final OrderModel order;
  final bool isAdminMode;

  const OrderItemCard({
    super.key,
    required this.order,
    required this.isAdminMode,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormat(
      'MMM dd, yyyy - hh:mm a',
    ).format(order.createdAt);

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          AppRoutes.orderDetailsScreen,
          pathParameters: {'orderId': order.id},
          extra: {'order': order, 'isAdmin': isAdminMode},
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Order ID & Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  data: "Order #${order.id.substring(0, 6).toUpperCase()}",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  data: formattedDate,
                  fontSize: 12.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            SizedBox(height: 8.h),

            // Show User Name if Admin
            if (isAdminMode) ...[
              Row(
                children: [
                  CustomText(
                    data: "User: ",
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryColor,
                  ),
                  CustomText(
                    data: order.userName,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            ],

            const Divider(),
            SizedBox(height: 8.h),

            // Body: Total & Items count
            Row(
              children: [
                CustomText(
                  data: "${order.items.length} Items",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                CustomText(
                  data: "Total: ",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
                CustomText(
                  data: "\$${order.totalAmount}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                  fontFamily:
                      'EnglishFont', // Use your specific font family if needed
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // Footer: Status & Action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: _getStatusColor(
                        order.status,
                      ).withValues(alpha: 0.5),
                    ),
                  ),
                  child: CustomText(
                    data: order.status,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(order.status),
                  ),
                ),

                // Admin Action Button
                if (isAdminMode)
                  PopupMenuButton<String>(
                    onSelected: (newStatus) {
                      context.read<OrdersCubit>().updateOrderStatus(
                        order.id,
                        newStatus,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        children: [
                          CustomText(
                            data: "Change Status",
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 4.w),
                          const Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                    itemBuilder: (context) => [
                      _buildPopupMenuItem('Pending', 'Pending'),
                      _buildPopupMenuItem('Processing', 'Processing'),
                      _buildPopupMenuItem('Shipped', 'Shipped'),
                      _buildPopupMenuItem('Delivered', 'Delivered'),
                      _buildPopupMenuItem(
                        'Cancelled',
                        'Cancelled',
                        color: Colors.red,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    String text, {
    Color? color,
  }) {
    return PopupMenuItem(
      value: value,
      child: CustomText(data: text, color: color, fontSize: 14.sp),
    );
  }
}
