import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';

class CheckOutDetails extends StatelessWidget {
  const CheckOutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Subtotal
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: 'Subtotal:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                data: '\$200',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(height: 1, color: Colors.grey[300]),
          const SizedBox(height: 12),

          // Shipping
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: 'Shipping:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              CustomText(
                data: '\$4888',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Divider
          Container(height: 1, color: Colors.grey[300]),
          const SizedBox(height: 16),

          // Total
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: 'BagTotal:',
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              Row(
                children: [
                  CustomText(
                    data: '(3 items )',
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(width: 8),
                  CustomText(
                    data: '\$5000',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
