import 'dart:async';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/number_localizer.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({
    super.key,
    required this.cartModel,
    required this.deleteFromQuantity,
  });

  final CartModel cartModel;
  final void Function() deleteFromQuantity;

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  late int count;
  Timer? _debounceTimer;

  @override
  void initState() {
    count = widget.cartModel.quantity;
    super.initState();
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _saveToFirebase() {
    try {
      FireBaseFireStore().fireBaseFireStore
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("userCart")
          .doc(widget.cartModel.id)
          .update({"quantity": count});
    } catch (e) {
      debugPrint("error happened");
    }
  }

  void _updateQuantity(int newCount) {
    // Cancel التايمر القديم لو في واحد شغال
    _debounceTimer?.cancel();

    setState(() {
      count = newCount;
      widget.cartModel.quantity = newCount;
      context.read<CartPriceProvider>().refresh();
    });

    _debounceTimer = Timer(const Duration(milliseconds: 1500), () {
      _saveToFirebase();
    });
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
                  _updateQuantity(count - 1);
                } else if (count == 1) {
                  _debounceTimer?.cancel();
                  widget.deleteFromQuantity();
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
                if (count < widget.cartModel.availableStock) {
                  _updateQuantity(count + 1);
                }
              },
              child: Icon(Icons.add, color: theme.primaryColor, size: 16.sp),
            ),
          ],
        ),
      ),
    );
  }
}
