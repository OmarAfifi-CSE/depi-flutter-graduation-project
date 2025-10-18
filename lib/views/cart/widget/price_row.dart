import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:batrina/widgets/custom_text.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({super.key, required this.title, required this.suffix});
  final String title;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(data: title, fontSize: 14.sp, fontWeight: FontWeight.w700),
        suffix,
      ],
    );
  }
}
