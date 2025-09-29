import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/cart/widget/quant_counter.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Brand and product name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const CustomText(
                      data: 'Herschel Supply Co.',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 4.h),
                    const CustomText(
                      data: 'Daypack Backpack',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      data: '(270 ${loc!.review})',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              // Quantity and availability
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // counter
                  const QuantCounter(),
                  SizedBox(height: 16.h),
                  CustomText(
                    data: loc.availableinstock,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Description
          CustomText(
            data: loc.description,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),

          SizedBox(height: 8.h),
          const CustomText(
            data:
                'A roomy backpack from the specialists in everyday bags at Herschel Supply Co., featuring resilient canvas and a light-blue patina that feels just right for summer.',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
