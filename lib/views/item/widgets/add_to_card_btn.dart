import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCardBtn extends StatelessWidget {
  const AddToCardBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Price
          CustomText(
            data: '\$245.00',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
          const Spacer(),
          // Add to cart button
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 20),
                  SizedBox(width: 8.w),
                  CustomText(
                    data: loc!.addtocard,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
