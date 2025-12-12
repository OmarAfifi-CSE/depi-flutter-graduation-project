import 'package:batrina/controllers/cubit/profile/orders/orders_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/order_model.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  final bool isAdmin;

  const OrderDetailsScreen({
    super.key,
    required this.order,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final formattedDate = DateFormat(
      'MMM dd, yyyy - hh:mm a',
    ).format(order.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: CustomHeaderWidget(
          center: CustomText(
            data: "Order Details", // loc.orderDetails
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
          prefix: const BackArrow(),
        ),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header Info (ID, Date, Status)
            _buildSectionContainer(
              theme,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        data:
                            "Order #${order.id.substring(0, 6).toUpperCase()}",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      _buildStatusBadge(order.status),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    data: formattedDate,
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                  if (isAdmin) ...[
                    SizedBox(height: 12.h),
                    const Divider(),
                    SizedBox(height: 8.h),
                    CustomText(
                      data: "Customer: ${order.userName}",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                    // زرار تغيير الحالة للأدمن داخل التفاصيل
                    SizedBox(height: 10.h),
                    _buildAdminStatusDropdown(context, theme),
                  ],
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 2. Shipping Address
            CustomText(
              data: loc!.deliveryAddress,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            _buildSectionContainer(
              theme,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: theme.primaryColor,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      CustomText(
                        data: order.userName,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    data:
                        "${order.shippingAddress.street}, ${order.shippingAddress.city}, ${order.shippingAddress.country}",
                    fontSize: 13.sp,
                    color: Colors.grey[700],
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    data: "Phone: ${order.shippingAddress.phoneNumber}",
                    fontSize: 13.sp,
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 3. Products List
            CustomText(
              data: "${loc.products} (${order.items.length})",
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) =>
                  _buildProductItem(theme, order.items[index]),
            ),
            SizedBox(height: 20.h),

            // 4. Payment Summary
            CustomText(
              data: "Payment Summary", // loc.paymentSummary
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: 10.h),
            _buildSectionContainer(
              theme,
              child: Column(
                children: [
                  _buildSummaryRow("Subtotal", "\$${order.totalAmount}"),
                  // لو عندك تقسيم للسعر
                  SizedBox(height: 8.h),
                  _buildSummaryRow("Shipping", "Free"),
                  // أو قيمة الشحن
                  const Divider(height: 20),
                  _buildSummaryRow(
                    "Total Amount",
                    "\$${order.totalAmount}",
                    isTotal: true,
                    theme: theme,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionContainer(ThemeData theme, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: child,
    );
  }

  Widget _buildProductItem(ThemeData theme, CartModel item) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: theme.dividerColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 70.w,
              height: 70.w,
              child: BuildDynamicImage(imageUrl: item.thumbnail),
            ),
          ),
          SizedBox(width: 12.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data: item.productName,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  maxLines: 1,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (item.color.isNotEmpty)
                      _buildVariantBadge(theme, item.color),
                    if (item.size.isNotEmpty && item.size != "Standard") ...[
                      SizedBox(width: 8.w),
                      CustomText(
                        data: "Size: ${item.size}",
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      data: "\$${item.price}",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.primaryColor,
                    ),
                    CustomText(
                      data: "x${item.quantity}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantBadge(ThemeData theme, String colorHex) {
    Color color = Color(int.parse(colorHex.replaceFirst('#', '0xff')));
    return Container(
      width: 16.w,
      height: 16.w,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
    ThemeData? theme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          data: label,
          fontSize: isTotal ? 16.sp : 13.sp,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
          color: isTotal ? null : Colors.grey[700],
        ),
        CustomText(
          data: value,
          fontSize: isTotal ? 16.sp : 13.sp,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          color: isTotal ? theme?.primaryColor : null,
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'delivered':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.blue;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: CustomText(
        data: status,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  // Admin dropdown (Optional: needs providing OrdersCubit to this screen or handling logic)
  Widget _buildAdminStatusDropdown(BuildContext context, ThemeData theme) {
    return BlocProvider(
      create: (context) => OrdersCubit(), // لازم بروفايدر عشان نستخدم الدالة
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Change Order Status"),
                value: null,
                items:
                    [
                          'Pending',
                          'Processing',
                          'Shipped',
                          'Delivered',
                          'Cancelled',
                        ]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                onChanged: (val) {
                  if (val != null) {
                    context.read<OrdersCubit>().updateOrderStatus(
                      order.id,
                      val,
                    );
                    // ممكن تظهر رسالة نجاح هنا
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
