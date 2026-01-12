import 'package:batrina/controllers/cubit/cart/get_cart_cubit/get_cart_cubit.dart';
import 'package:batrina/controllers/cubit/cart/order_cubit/place_order_cubit.dart';
import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/controllers/provider/control_place_order_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/order_model.dart'; // تأكد من المسار
import 'package:batrina/models/payment_method_option.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/cart/checkout/address_selection/address_selection_sheet.dart';
import 'package:batrina/views/cart/checkout/widgets/product_card.dart';
import 'package:batrina/views/profile/shipping_address/widgets/address_card.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartModel> cartItems;
  final CartPriceProvider cartPriceProvider;

  const CheckoutScreen({
    super.key,
    required this.cartItems,
    required this.cartPriceProvider,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late GetAddressesCubit getAddressesCubit;
  int _selectedPaymentMethod = 1;

  @override
  void initState() {
    super.initState();
    getAddressesCubit = GetAddressesCubit();
  }

  void _showAddressSelectionSheet(
    ControlPlaceOrderProvider controlPlaceOrderButtonProvider,
    GetAddressesCubit getAddressesCubit,
  ) {
    final theme = Theme.of(context);

    showModalBottomSheet<AddressModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: getAddressesCubit,
          child: ChangeNotifierProvider.value(
            value: controlPlaceOrderButtonProvider,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: const AddressSelectionSheet(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final List<PaymentMethodOption> paymentMethods = [
      PaymentMethodOption(
        id: 1,
        title: loc!.payOnDelivery,
        subtitle: loc.payOnDeliverySubtitle,
        icon: Icons.money_rounded,
        color: Colors.green,
      ),
      // PaymentMethodOption(
      //   id: 2,
      //   title: "Credit Card",
      //   subtitle: "**** **** **** 1234",
      //   icon: Icons.credit_card,
      //   color: Colors.blue,
      // ),
      // PaymentMethodOption(
      //   id: 3,
      //   title: "Wallet",
      //   subtitle: "Vodafone / Instapay",
      //   icon: Icons.account_balance_wallet,
      //   color: Colors.orange,
      // ),
    ];

    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => getAddressesCubit..getAddresses()),
        BlocProvider(create: (context) => PlaceOrderCubit()),
        ChangeNotifierProvider(
          create: (context) => ControlPlaceOrderProvider(),
        ),
      ],
      child: BlocListener<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) {
          if (state is PlaceOrderLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (ctx) => Center(
                child: Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: CupertinoActivityIndicator(color: theme.primaryColor),
                ),
              ),
            );
          } else if (state is PlaceOrderSuccess) {
            Navigator.pop(context);
            widget.cartPriceProvider.resetCart();
            context.read<GetCartCubit>().clearCartLocal();
            context.pushNamed(AppRoutes.orderSuccessfulScreen);
          } else if (state is PlaceOrderFailure) {
            Navigator.pop(context);
            CustomSnackBar.showSnackBar(
              context: context,
              message: state.errMessage,
              color: Colors.red,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: CustomHeaderWidget(
              center: CustomText(
                data: loc.checkout,
                textAlign: TextAlign.center,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              prefix: const BackArrow(),
            ),
            leading: const SizedBox(),
            leadingWidth: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Address Section
                            CustomText(
                              data: loc.deliveryAddress,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 18.h),
                            _buildAddressSection(theme),
                            SizedBox(height: 24.h),

                            // Payment Method Section
                            CustomText(
                              data: loc.paymentMethod,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 12.h),
                            RadioGroup<int>(
                              groupValue: _selectedPaymentMethod,
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedPaymentMethod = val;
                                  });
                                }
                              },
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: paymentMethods.length,
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  return _buildPaymentMethodItem(
                                    paymentMethods[index],
                                    theme,
                                    appColors,
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 24.h),

                            // Products Section
                            CustomText(
                              data: loc.products,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 12.h),
                            ListView.separated(
                              itemCount: widget.cartItems.length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 16.h),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return ProductCard(
                                  cartModel: widget.cartItems[index],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom Section with Total and Place Order Button
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 15.h,
                    ),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    data: loc.total,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(width: 8.w),
                                  Flexible(
                                    child: CustomText(
                                      data:
                                          '(${widget.cartPriceProvider.count} ${loc.items})',
                                      fontSize: 13.sp,
                                      color: appColors.containerBorder,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (widget.cartPriceProvider.discount !=
                                      0) ...[
                                    Flexible(
                                      child: CustomText(
                                        data:
                                            '\$${widget.cartPriceProvider.total}',
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                        maxLines: 1,
                                        fontFamily: AppFonts.englishFontFamily,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                  ],
                                  Flexible(
                                    child: CustomText(
                                      lined:
                                          widget.cartPriceProvider.discount !=
                                          0,
                                      data:
                                          '\$${widget.cartPriceProvider.totalNoDis}',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          widget.cartPriceProvider.discount != 0
                                          ? theme.dividerColor
                                          : null,
                                      maxLines: 1,
                                      fontFamily: AppFonts.englishFontFamily,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.w),
                        SizedBox(
                          height: 50.h,
                          child: Consumer<ControlPlaceOrderProvider>(
                            builder: (context, value, child) {
                              return CustomElevatedButton(
                                onPressed: value.currentAddress == null
                                    ? null
                                    : () {
                                        final order = OrderModel(
                                          userId: FirebaseAuth
                                              .instance
                                              .currentUser!
                                              .uid,
                                          userName:
                                              FireBaseFireStore
                                                  .currentUser
                                                  ?.name ??
                                              "User",
                                          totalAmount: widget
                                              .cartPriceProvider
                                              .totalNoDis,
                                          status: 'Pending',
                                          shippingAddress:
                                              value.currentAddress!,
                                          items: widget.cartItems,
                                          createdAt: DateTime.now(),
                                        );

                                        context
                                            .read<PlaceOrderCubit>()
                                            .placeOrder(order: order);
                                      },
                                extend: true,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 24.w,
                                  vertical: 12.h,
                                ),
                                outlinedBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.r),
                                ),
                                buttonChild: CustomText(
                                  data: loc.placeOrder,
                                  fontSize: 16.sp,
                                  color: theme.scaffoldBackgroundColor,
                                  fontWeight: FontWeight.w600,
                                  forceStrutHeight: true,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddressSection(ThemeData theme) {
    return BlocConsumer<GetAddressesCubit, GetAddressesState>(
      listener: (context, state) {
        if (state is GetAddressesFailure) {
          CustomSnackBar.showSnackBar(
            context: context,
            message: state.error,
            color: Colors.red,
          );
        }
        if (state is GetAddressesSuccess && state.addresses.isNotEmpty) {
          AddressModel startingAddressModel;
          try {
            startingAddressModel = state.addresses.firstWhere(
              (element) =>
                  element.id == FireBaseFireStore.currentUser?.mainAddressId,
            );
          } catch (e) {
            startingAddressModel = state.addresses.first;
          }
          context.read<ControlPlaceOrderProvider>().setMainAddress(
            startingAddressModel,
          );
        }
      },
      builder: (context, state) {
        if (state is GetAddressesSuccess) {
          List<AddressModel> addresses = (state).addresses;
          if (addresses.isEmpty) {
            return SizedBox(
              height: 180.h,
              child: AddressCard(
                addressModel: null,
                customChild: _buildEmptyState(context),
              ),
            );
          }
          final displayedAddress = context
              .watch<ControlPlaceOrderProvider>()
              .currentAddress;

          if (displayedAddress == null) {
            return SizedBox(
              height: 180.h,
              child: AddressCard(
                addressModel: null,
                customChild: Center(
                  child: CupertinoActivityIndicator(color: theme.primaryColor),
                ),
              ),
            );
          }

          return GestureDetector(
            onTap: () {
              _showAddressSelectionSheet(
                context.read<ControlPlaceOrderProvider>(),
                getAddressesCubit,
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 180.h,
                  child: AddressCard(addressModel: displayedAddress),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: EdgeInsetsGeometry.directional(end: 16.w),
                    child: Icon(
                      Icons.edit_outlined,
                      color: theme.primaryColor.withValues(alpha: 0.6),
                      size: 24.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 180.h,
            child: AddressCard(
              addressModel: null,
              customChild: Center(
                child: CupertinoActivityIndicator(color: theme.primaryColor),
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildPaymentMethodItem(
    PaymentMethodOption method,
    ThemeData theme,
    AppColorTheme appColors,
  ) {
    // final isSelected = _selectedPaymentMethod == method.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method.id;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(12.0.w),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12.r),
          // border: Border.all(
          //   color: isSelected ? theme.primaryColor : Colors.transparent,
          //   width: 1.5,
          // ),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: 0.1),
              blurRadius: 10.r,
              spreadRadius: 1.r,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: method.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(method.icon, color: method.color, size: 24.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: method.title,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    data: method.subtitle,
                    fontSize: 12.sp,
                    color: appColors.secondaryText,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Radio<int>(value: method.id, activeColor: theme.primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () async {
        await context.pushNamed(AppRoutes.addressesScreen);
        if (mounted) {
          context.read<GetAddressesCubit>().getAddresses();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: .1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.add,
              size: 30.sp,
              color: theme.primaryColor.withValues(alpha: .6),
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            data: loc!.noAddressFound,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: 6.h),
          CustomText(
            data: loc.pleaseAddAddress,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: appColors.secondaryText,
          ),
        ],
      ),
    );
  }
}
