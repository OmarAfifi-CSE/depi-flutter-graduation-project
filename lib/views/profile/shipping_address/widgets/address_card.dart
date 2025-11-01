import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/styling/app_colors.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
    required this.addressModel,
    this.onAddAddress,
    this.customChild,
  });

  final AddressModel? addressModel;
  final VoidCallback? onAddAddress;
  final Widget? customChild;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(16.r),
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.scaffoldBackgroundColor.withValues(alpha: .8),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, -2.h),
          ),
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: .15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child:
          customChild ??
          (addressModel == null
              ? _buildEmptyState(context)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRow(loc!.street, addressModel!.street, context),
                    _buildRow(loc.city, addressModel!.city, context),
                    _buildRow(
                      loc.phoneNumber,
                      addressModel!.phoneNumber,
                      context,
                    ),
                    _buildRow(loc.country, addressModel!.country, context),
                  ],
                )),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);
    return Column(
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
            Icons.location_off_outlined,
            size: 30.sp,
            color: theme.primaryColor.withValues(alpha: .6),
          ),
        ),
        SizedBox(height: 12.h),
        CustomText(
          data: loc!.noMainAddress,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 6.h),
        CustomText(
          data: loc.dragAnAddress,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: appColors.secondaryText,
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value, BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Row(
      children: [
        CustomText(
          textAlign: TextAlign.start,
          data: "$label: ",
          fontWeight: FontWeight.w700,
          forceStrutHeight: true,
          fontSize: 16.sp,
        ),
        Expanded(
          child: CustomText(
            textAlign: TextAlign.start,
            data: value,
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            forceStrutHeight: true,
            color: appColors.secondaryText,
          ),
        ),
      ],
    );
  }
}
