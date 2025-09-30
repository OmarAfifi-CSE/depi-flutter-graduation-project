import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/custom_text.dart';

class StockCountText extends StatelessWidget {
  const StockCountText({super.key});

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = context.watch<ProductProvider>();
    final theme = Theme.of(context);
    return CustomText(
      data: "${productProvider.currentVariantStock} available in stocks ",
      fontSize: 10.sp,
      fontWeight: FontWeight.w600,
      color: productProvider.currentVariantStock == 0
          ? Colors.red
          : theme.primaryColor,
    );
  }
}
