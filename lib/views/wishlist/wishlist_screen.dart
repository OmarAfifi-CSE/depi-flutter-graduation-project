import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/wishlist/widgets/wishlist_body.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: CustomHeaderWidget(
          center: CustomText(
            data: loc!.wishlist,
            textAlign: TextAlign.center,
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
          ),
          prefix: const BackArrow(),
        ),
        leading: const SizedBox(),
        leadingWidth: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: const WishlistBody(),
      ),
    );
  }
}
