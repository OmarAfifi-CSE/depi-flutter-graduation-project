import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Stars extends StatelessWidget {
  const Stars({super.key, required this.numberOfStart});
  final int numberOfStart;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            return Icon(
              index < numberOfStart ? Icons.star : Icons.star_border,
              color: Colors.orange,
              size: 16.sp,
            );
          }),
        ),
      ],
    );
  }
}
