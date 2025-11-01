import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/controllers/provider/control_place_order_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/cart/checkout/address_selection/widgets/address_selection_sheet.dart';
import 'package:batrina/views/cart/checkout/widgets/product_card.dart';
import 'package:batrina/views/profile/shipping_address/widgets/address_card.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
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
  @override
  void initState() {
    super.initState();
  }

  void _showAddressSelectionSheet(
    ControlPlaceOrderProvider controlPlaceOrderButtonProvider,
    List<AddressModel> availableAddresses,
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
        return ChangeNotifierProvider.value(
          value: controlPlaceOrderButtonProvider,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8,
            ),
            child: AddressSelectionSheet(
              availableAddresses: availableAddresses,
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

    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => GetAddressesCubit()..getAddresses()),
        ChangeNotifierProvider(
          create: (context) => ControlPlaceOrderProvider(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            center: CustomText(
              data: loc!.checkout,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: loc.deliveryAddress,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 18.h),
                      BlocConsumer<GetAddressesCubit, GetAddressesState>(
                        listener: (context, state) {
                          if (state is GetAddressesFailure) {
                            CustomSnackBar.showSnackBar(
                              context: context,
                              message: state.error,
                              color: Colors.red,
                            );
                          }
                          // Use the listener for side-effects, like setting the initial state in another provider.
                          if (state is GetAddressesSuccess &&
                              state.addresses.isNotEmpty) {
                            AddressModel startingAddressModel;
                            try {
                              startingAddressModel = state.addresses.firstWhere(
                                (element) =>
                                    element.id ==
                                    FireBaseFireStore
                                        .currentUser
                                        ?.mainAddressId,
                              );
                            } catch (e) {
                              startingAddressModel = state.addresses.first;
                            }
                            // Use `read` in a listener; it doesn't need to listen for changes here.
                            context
                                .read<ControlPlaceOrderProvider>()
                                .setMainAddress(startingAddressModel);
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

                            // **THE FIX**: Watch the provider for changes. This ensures the UI rebuilds
                            // when a new address is selected from the bottom sheet.
                            final displayedAddress = context
                                .watch<ControlPlaceOrderProvider>()
                                .currentAddress;

                            // Show a loader until the listener sets the initial address.
                            if (displayedAddress == null) {
                              return SizedBox(
                                height: 180.h,
                                child: AddressCard(
                                  addressModel: null,
                                  customChild: Center(
                                    child: CupertinoActivityIndicator(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () {
                                _showAddressSelectionSheet(
                                  context.read<ControlPlaceOrderProvider>(),
                                  addresses,
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: 180.h,
                                    child: AddressCard(
                                      addressModel: displayedAddress,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Padding(
                                      padding: EdgeInsetsGeometry.directional(
                                        end: 16.w,
                                      ),
                                      child: Icon(
                                        Icons.edit_outlined,
                                        color: theme.primaryColor.withValues(
                                          alpha: 0.6,
                                        ),
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            // Show a loader while addresses are being fetched.
                            return SizedBox(
                              height: 180.h,
                              child: AddressCard(
                                addressModel: null,
                                customChild: Center(
                                  child: CupertinoActivityIndicator(
                                    color: theme.primaryColor,
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 24.h),
                      CustomText(
                        data: loc.products,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: widget.cartItems.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 25.w,
                      vertical: 12.h,
                    ),
                    itemBuilder: (context, index) {
                      return ProductCard(cartModel: widget.cartItems[index]);
                    },
                  ),
                ),
                SizedBox(height: 18.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                data: loc.total,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(width: 8.w),
                              CustomText(
                                data:
                                    '(${widget.cartPriceProvider.count} ${loc.items})',
                                fontSize: 13.sp,
                                color: appColors.containerBorder,
                                fontWeight: FontWeight.w500,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.cartPriceProvider.discount != 0) ...[
                                Flexible(
                                  child: CustomText(
                                    data: '\$${widget.cartPriceProvider.total}',
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
                                  lined: widget.cartPriceProvider.discount != 0,
                                  data:
                                      '\$${widget.cartPriceProvider.totalNoDis}',
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: widget.cartPriceProvider.discount != 0
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
                      SizedBox(
                        height: 50.h,
                        child: Consumer<ControlPlaceOrderProvider>(
                          builder: (context, value, child) {
                            return CustomElevatedButton(
                              onPressed: value.currentAddress == null
                                  ? null
                                  : () {},
                              extend: true,
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
