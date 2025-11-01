import 'package:batrina/controllers/provider/control_place_order_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/views/profile/shipping_address/widgets/address_card.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AddressSelectionSheet extends StatelessWidget {
  final List<AddressModel> availableAddresses;

  const AddressSelectionSheet({super.key, required this.availableAddresses});

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
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: availableAddresses.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final address = availableAddresses[index];
                final bool isSelected = address.id == selectedAddressId;
                return GestureDetector(
                  onTap: () {
                    context.read<ControlPlaceOrderProvider>().setMainAddress(
                      address,
                    );
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: isSelected
                          ? Border.all(color: theme.primaryColor, width: 2.5)
                          : Border.all(
                              color: theme.primaryColor.withValues(alpha: 0.3),
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
            ),
          ),
        ],
      ),
    );
  }
}
