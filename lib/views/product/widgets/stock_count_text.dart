import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/number_localizer.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/l10n/app_localizations.dart';

class StockCountText extends StatelessWidget {
  const StockCountText({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    return CustomText(
      data:
          "${NumberLocalizer.formatNumber(productProvider.currentVariantStock.toInt(), Localizations.localeOf(context).languageCode)} ${loc!.availableinstock} ",
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: productProvider.currentVariantStock == 0
          ? Colors.red
          : theme.primaryColor,
    );
  }
}
