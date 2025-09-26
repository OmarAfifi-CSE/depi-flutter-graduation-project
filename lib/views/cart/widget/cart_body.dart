import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/widgets/custom_button.dart';
import 'package:batrina/views/cart/widget/cart_item.dart';
import 'package:batrina/views/cart/widget/check_out_details.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // My Cart title
        _buildCartTitle(),
        const SizedBox(height: 20),

        // Cart items
        Expanded(child: _buildCartItems()),

        // Order summary
        const CheckOutDetails(),
        const SizedBox(height: 20),

        // Checkout button
        const CustomButton(text: 'Proceed to Checkout'),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCartTitle() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: CustomText(
        data: 'My Cart',
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildCartItems() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const CardItem();
      },
    );
  }
}
