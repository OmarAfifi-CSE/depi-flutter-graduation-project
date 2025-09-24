import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';

class QuantCounter extends StatelessWidget {
  const QuantCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus button
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove, color: Colors.black, size: 17),
          ),

          // Quantity
          Container(
            width: 40,
            alignment: Alignment.center,
            child: const CustomText(
              data: '1',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
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
