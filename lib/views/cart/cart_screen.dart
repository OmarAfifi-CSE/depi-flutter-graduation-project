import 'package:flutter/material.dart';
import 'package:batrina/views/cart/widget/cart_body.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: CartViewBody(),
      ),
    );
  }
}
