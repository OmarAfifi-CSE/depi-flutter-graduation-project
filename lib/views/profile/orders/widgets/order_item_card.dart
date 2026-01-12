import 'package:batrina/controllers/cubit/profile/orders/orders_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/order_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

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

  String _getLocalizedStatus(BuildContext context, String status) {
    final loc = AppLocalizations.of(context)!;
    switch (status.toLowerCase()) {
      case 'pending':
        return loc.statusPending;
      case 'processing':
        return loc.statusProcessing;
      case 'shipped':
        return loc.statusShipped;
      case 'delivered':
        return loc.statusDelivered;
      case 'cancelled':
        return loc.statusCancelled;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final formattedDate = DateFormat(
      'MMM dd, yyyy',
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
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.1),
              blurRadius: 10.r,
              spreadRadius: 1.r,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Order ID & Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  data: loc!.orderNumber(
                    order.id.substring(0, 6).toUpperCase(),
                  ),
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
                    data: loc.userLabel,
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
                  data: loc.itemsCount(order.items.length),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                const Spacer(),
                CustomText(
                  data: loc.totalLabel,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
                CustomText(
                  data: "\$${order.totalAmount}",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
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
                    data: _getLocalizedStatus(context, order.status),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusColor(order.status),
                  ),
                ),

                // Admin Action Button
                if (isAdminMode)
                  PopupMenuButton<String>(
                    color: theme.scaffoldBackgroundColor,
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
                            data: AppLocalizations.of(context)!.changeStatus,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(width: 4.w),
                          const Icon(Icons.arrow_drop_down, size: 18),
                        ],
                      ),
                    ),
                    itemBuilder: (context) {
                      final loc = AppLocalizations.of(context)!;
                      return [
                        _buildPopupMenuItem('Pending', loc.statusPending),
                        _buildPopupMenuItem('Processing', loc.statusProcessing),
                        _buildPopupMenuItem('Shipped', loc.statusShipped),
                        _buildPopupMenuItem('Delivered', loc.statusDelivered),
                        _buildPopupMenuItem(
                          'Cancelled',
                          loc.statusCancelled,
                          color: Colors.red,
                        ),
                      ];
                    },
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
