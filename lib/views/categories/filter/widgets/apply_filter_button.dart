import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ApplyFilterButton extends StatelessWidget {
  const ApplyFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final filter = Provider.of<FilterProvider>(context);
    return ElevatedButton(
      onPressed: () {
        final filter = Provider.of<FilterProvider>(context, listen: false);
        context.pushNamed(AppRoutes.filteredProductsScreen);
      },
      style: ElevatedButton.styleFrom(
        //backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        elevation: 0,
      ),
      child: CustomText(data:loc!.applyNow, fontSize: 16.sp, fontWeight: FontWeight.w600)
    );
  }
}
