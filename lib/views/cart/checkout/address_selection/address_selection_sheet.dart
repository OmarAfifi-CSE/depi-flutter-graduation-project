import 'package:batrina/controllers/cubit/profile/get_addresses_cubit/get_addresses_cubit.dart';
import 'package:batrina/controllers/provider/control_place_order_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/profile/shipping_address/widgets/address_card.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AddressSelectionSheet extends StatefulWidget {
  const AddressSelectionSheet({super.key});

  @override
  State<AddressSelectionSheet> createState() => _AddressSelectionSheetState();
}

class _AddressSelectionSheetState extends State<AddressSelectionSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final selectedAddressId = context
        .watch<ControlPlaceOrderProvider>()
        .currentAddress
        ?.id;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              height: 5.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Sheet Title
          Padding(
            padding: EdgeInsets.only(left: 5.w, bottom: 15.h),
            child: CustomText(
              data: loc!.selectDeliveryAddress,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: BlocConsumer<GetAddressesCubit, GetAddressesState>(
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
                          FireBaseFireStore.currentUser?.mainAddressId,
                    );
                  } catch (e) {
                    startingAddressModel = state.addresses.first;
                  }
                  // Use `read` in a listener; it doesn't need to listen for changes here.
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
                        customChild: _buildAddAddress(context),
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: addresses.length + 1,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      if (index == addresses.length) {
                        return _buildAddAddress(context);
                      }
                      final address = addresses[index];
                      final bool isSelected = address.id == selectedAddressId;
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<ControlPlaceOrderProvider>()
                              .setMainAddress(address);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: isSelected
                                ? Border.all(
                                    color: theme.primaryColor,
                                    width: 2.5,
                                  )
                                : Border.all(
                                    color: theme.primaryColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    width: 1,
                                  ),
                          ),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 180.h,
                                child: AddressCard(addressModel: address),
                              ),
                              if (isSelected)
                                Positioned.directional(
                                  textDirection: Directionality.of(context),
                                  top: 0,
                                  end: 0,
                                  child: Container(
                                    margin: EdgeInsets.all(4.r),
                                    padding: EdgeInsets.all(2.r),
                                    decoration: BoxDecoration(
                                      color: theme.scaffoldBackgroundColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: theme.primaryColor,
                                      size: 28.sp,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
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
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddress(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return GestureDetector(
      onTap: () async {
        await context.pushNamed(AppRoutes.addressesScreen);
        if (mounted) {
          context.read<GetAddressesCubit>().getAddresses();
        }
      },
      child: Container(
        height: 180.h,
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: theme.primaryColor.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
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
              data: loc!.addNewAddress,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
