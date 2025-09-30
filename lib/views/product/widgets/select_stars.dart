import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectStars extends StatefulWidget {
  const SelectStars({super.key});
  static int numberOfStart = 1;

  @override
  State<SelectStars> createState() => _SelectStarsState();
}

class _SelectStarsState extends State<SelectStars> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5.w,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              SelectStars.numberOfStart = index + 1;
            });
          },
          child: Icon(
            index < SelectStars.numberOfStart ? Icons.star : Icons.star_border,
            color: Colors.orange,
            size: 30.sp,
          ),
        );
      }),
    );
  }
}
