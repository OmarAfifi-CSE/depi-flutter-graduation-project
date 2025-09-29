import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends StatelessWidget {
  final double price;
  final String desc;
  final String brand;
  final String img;

  const ProductCardWidget({
    super.key,
    required this.price,
    required this.desc,
    required this.brand,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Column(
          children: [
            CustomText(
              data: brand,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            CustomText(
              data: desc,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              data: "$price\$",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}
