import 'package:batrina/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../controllers/provider/cart_price_provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../number_localizer.dart';
import '../../../styling/app_colors.dart';
import '../../../widgets/custom_text.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({super.key, required this.cartModel});

  final CartModel cartModel;

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  late int count;
  @override
  void initState() {
    count = widget.cartModel.quantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final localeCode = Localizations.localeOf(context).languageCode;

    return Container(
      alignment: Alignment.center,
      height: 30.h,
      decoration: BoxDecoration(
        color: appColors.countButtonBackground,
        borderRadius: BorderRadius.circular(100.r),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 10.w),
        child: Row(
          spacing: 13.w,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (count > 1) {
                  setState(() {
                    widget.cartModel.quantity--;
                    context.read<CartPriceProvider>().refresh();

                    count--;
                  });
                }
              },
              child: Icon(Icons.remove, color: theme.primaryColor, size: 16.sp),
            ),
            CustomText(
              forceStrutHeight: true,
              data: NumberLocalizer.formatNumber(count.toString(), localeCode),

              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.cartModel.quantity++;
                  context.read<CartPriceProvider>().refresh();

                  count++;
                });
              },
              child: Icon(Icons.add, color: theme.primaryColor, size: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
