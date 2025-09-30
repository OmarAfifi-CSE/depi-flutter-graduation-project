import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/widgets/color_option.dart';
import 'package:batrina/views/product/widgets/size_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductSelection extends StatelessWidget {
  const ProductSelection({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizeOption(sizes: productModel.availableSizes)),
        SizedBox(width: 10.w),
        Expanded(child: ColorOption(colors: productModel.availableColors)),
      ],
    );
  }
}
