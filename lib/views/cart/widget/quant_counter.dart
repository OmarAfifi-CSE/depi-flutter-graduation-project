import 'package:flutter/material.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuantCounter extends StatelessWidget {
  const QuantCounter({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return Container(
      height: 36.h,
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1),
      decoration: BoxDecoration(
        color: appColors.countButtonBackground,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Minus button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove, color: Colors.black, size: 17),
          ),
          const CustomText(
            data: '1',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),

          // Plus button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add, color: Colors.black, size: 17),
          ),
        ],
      ),
    );
  }
}
