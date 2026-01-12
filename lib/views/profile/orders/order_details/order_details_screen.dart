import 'dart:ui' as ui;
import 'package:batrina/controllers/cubit/profile/orders/order_details/order_details_cubit.dart'; // تأكد من المسار
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/order_model.dart';
import 'package:batrina/styling/app_fonts.dart';
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
    // 1. إنشاء الـ Cubit وبدء الاستماع للأوردر
    return BlocProvider(
      create: (context) => OrderDetailsCubit()..monitorOrder(order),
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: AppLocalizations.of(context)!.orderDetails,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
            prefix: const BackArrow(),
          ),
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        // 2. استخدام BlocBuilder لتحديث الواجهة عند تغير حالة الأوردر
        body: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
          builder: (context, state) {
            // تحديد الأوردر الحالي (إما من الـ state أو المبدئي)
            OrderModel currentOrder = order;

            if (state is OrderDetailsSuccess) {
              currentOrder = state.order;
            } else if (state is OrderDetailsFailure) {
              return Center(child: Text(state.errMessage));
            }

            final theme = Theme.of(context);
            final loc = AppLocalizations.of(context)!;
            final formattedDate = DateFormat(
              'MMM dd, yyyy - hh:mm a',
            ).format(currentOrder.createdAt);
            const double shippingCost = 7.95;
            double subTotal = currentOrder.items.fold(
              0.0,
              (sum, item) => sum + (item.price * item.quantity),
            );
            double totalAmount = currentOrder.totalAmount;
            return SingleChildScrollView(
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
                            Flexible(
                              child: CustomText(
                                data: loc.orderNumber(
                                  currentOrder.id.toUpperCase(),
                                ),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            _buildStatusBadge(context, currentOrder.status),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          data: formattedDate,
                          fontSize: 13.sp,
                          color: theme.primaryColor.withValues(alpha: 0.5),
                        ),
                        if (isAdmin) ...[
                          SizedBox(height: 12.h),
                          const Divider(),
                          SizedBox(height: 8.h),
                          CustomText(
                            data:
                                "${loc.customerLabel}${currentOrder.userName}",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryColor,
                          ),
                          SizedBox(height: 10.h),
                          // نمرر الـ currentOrder عشان الـ ID يكون صح
                          _buildAdminStatusDropdown(
                            context,
                            theme,
                            currentOrder,
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 2. Shipping Address
                  CustomText(
                    data: loc.deliveryAddress,
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
                              data: currentOrder.userName,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          data:
                              "${currentOrder.shippingAddress.street}, ${currentOrder.shippingAddress.city}, ${currentOrder.shippingAddress.country}",
                          fontSize: 13.sp,
                          color: theme.primaryColor.withValues(alpha: 0.7),
                        ),
                        SizedBox(height: 5.h),
                        CustomText(
                          data:
                              "${loc.phoneLabel}${currentOrder.shippingAddress.phoneNumber}",
                          fontSize: 13.sp,
                          color: theme.primaryColor.withValues(alpha: 0.7),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 3. Products List
                  CustomText(
                    data: "${loc.products} (${currentOrder.items.length})",
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10.h),
                  Directionality(
                    textDirection: ui.TextDirection.ltr,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: currentOrder.items.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) =>
                          _buildProductItem(theme, currentOrder.items[index]),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // 4. Payment Summary
                  CustomText(
                    data: loc.paymentSummary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 10.h),
                  _buildSectionContainer(
                    theme,
                    child: Column(
                      children: [
                        // Subtotal
                        _buildSummaryRow(
                          loc.subtotal,
                          "\$${subTotal.toStringAsFixed(2)}",
                          theme: theme,
                        ),
                        SizedBox(height: 8.h),
                        // Shipping
                        _buildSummaryRow(
                          loc.shipping,
                          "\$${shippingCost.toStringAsFixed(2)}",
                          theme: theme,
                        ),
                        const Divider(height: 20),
                        // Total
                        _buildSummaryRow(
                          loc.totalAmount,
                          "\$${totalAmount.toStringAsFixed(2)}",
                          isTotal: true,
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSectionContainer(ThemeData theme, {required Widget child}) {
    return Container(
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
      child: child,
    );
  }

  Widget _buildProductItem(ThemeData theme, CartModel item) {
    return Container(
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: SizedBox(
              width: 70.w,
              height: 70.w,
              child: BuildDynamicImage(imageUrl: item.thumbnail),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data: item.productName,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.englishFontFamily,
                  maxLines: 1,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    if (item.color.isNotEmpty)
                      _buildVariantBadge(theme, item.color),
                    if (item.size.isNotEmpty && item.size != "Standard") ...[
                      SizedBox(width: 8.w),
                      Builder(
                        builder: (context) {
                          final loc = AppLocalizations.of(context)!;
                          return CustomText(
                            data: "${loc.sizeLabel}${item.size}",
                            fontSize: 12.sp,
                            color: theme.primaryColor.withValues(alpha: 0.7),
                            forceStrutHeight: true,
                          );
                        },
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
                      fontFamily: AppFonts.englishFontFamily,
                    ),
                    CustomText(
                      data: "x${item.quantity}",
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppFonts.englishFontFamily,
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
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.5)),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isTotal = false,
    required ThemeData theme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          data: label,
          fontSize: isTotal ? 16.sp : 13.sp,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
          color: isTotal ? null : theme.primaryColor.withValues(alpha: 0.7),
        ),
        CustomText(
          data: value,
          fontSize: isTotal ? 16.sp : 13.sp,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
          color: isTotal ? theme.primaryColor : null,
        ),
      ],
    );
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

  Widget _buildStatusBadge(BuildContext context, String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'processing':
        color = Colors.blue;
        break;
      case 'shipped':
        color = Colors.purple;
        break;
      case 'delivered':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: CustomText(
        data: _getLocalizedStatus(context, status),
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }

  Widget _buildAdminStatusDropdown(
    BuildContext context,
    ThemeData theme,
    OrderModel currentOrder,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: theme.scaffoldBackgroundColor,
          isExpanded: true,
          hint: Text(AppLocalizations.of(context)!.changeOrderStatus),
          value: null,
          items: () {
            final loc = AppLocalizations.of(context)!;
            return [
              DropdownMenuItem(
                value: 'Pending',
                child: Text(loc.statusPending),
              ),
              DropdownMenuItem(
                value: 'Processing',
                child: Text(loc.statusProcessing),
              ),
              DropdownMenuItem(
                value: 'Shipped',
                child: Text(loc.statusShipped),
              ),
              DropdownMenuItem(
                value: 'Delivered',
                child: Text(loc.statusDelivered),
              ),
              DropdownMenuItem(
                value: 'Cancelled',
                child: Text(loc.statusCancelled),
              ),
            ];
          }(),
          onChanged: (val) {
            if (val != null) {
              context.read<OrderDetailsCubit>().updateStatus(
                currentOrder.id,
                val,
              );
            }
          },
        ),
      ),
    );
  }
}
