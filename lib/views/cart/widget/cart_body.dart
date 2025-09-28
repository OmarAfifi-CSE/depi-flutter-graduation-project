import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/widgets/custom_button.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/cart/widget/cart_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/cart/widget/check_out_details.dart';
import 'package:batrina/views/auth/widgets/custom_elevated_button.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Column(
      children: [
        // My Cart title
        _buildCartTitle(context),
        SizedBox(height: 14.h),
        // Cart items
        Expanded(child: _buildCartItems()),

        // Order summary
        const CheckOutDetails(),
        SizedBox(height: 30.h),

        // Checkout button
        CustomElevatedButton(
          onPressed: () {},
          buttonChild: CustomText(
            data: loc!.processtocheckout,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: theme.scaffoldBackgroundColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCartTitle(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Align(
      alignment: Alignment.centerLeft,
      child: CustomText(
        data: loc!.mycart,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildCartItems() {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return const CardItem();
      },
    );
  }
}
