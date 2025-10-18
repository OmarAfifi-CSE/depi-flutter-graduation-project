import 'package:batrina/models/address_model.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/styling/app_colors.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.addressModel, this.onAddAddress});
  final AddressModel? addressModel;
  final VoidCallback? onAddAddress;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(20.r),
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: .15),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: addressModel == null
          ? _buildEmptyState(context)
          : Column(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRow('Street:', addressModel!.street, context),
                _buildRow('City:', addressModel!.city, context),
                _buildRow('Phone number:', addressModel!.phoneNumber, context),
                _buildRow('Country:', addressModel!.country, context),
              ],
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

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
          data: 'No Main Address',
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          fontFamily: AppFonts.englishFontFamily,
        ),

        SizedBox(height: 6.h),

        CustomText(
          data: 'Drag an address ',
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: appColors.secondaryText,
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value, BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Row(
      textDirection: TextDirection.ltr,
      children: [
        CustomText(
          data: "$label : ",
          fontFamily: AppFonts.englishFontFamily,
          fontWeight: FontWeight.w700,
          fontSize: 15.sp,
        ),
        Expanded(
          child: CustomText(
            textAlign: TextAlign.start,
            data: value,
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
            fontFamily: AppFonts.englishFontFamily,
            color: appColors.secondaryText,
          ),
        ),
      ],
    );
  }
}
