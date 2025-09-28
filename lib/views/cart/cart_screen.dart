import 'package:flutter/material.dart';
import 'package:batrina/views/cart/widget/cart_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: const CartViewBody(),
      ),
    );
  }
}
