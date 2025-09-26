import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/views/cart/widget/quant_counter.dart';

class ItemDetails extends StatelessWidget {
  const ItemDetails({super.key,});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha((0.1 * 255).toInt()),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Brand and product name
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  CustomText(
                    data: 'Herschel Supply Co.',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                    data: 'Daypack Backpack',
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 4),
                  CustomText(
                    data: '(270 Review)',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ],
              ),
              // Quantity and availability
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  // counter
                  QuantCounter(),
                  SizedBox(height: 16),
                  CustomText(
                    data: 'Available in stock',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),

          // Description
          CustomText(
            data: 'Description',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          SizedBox(height: 8),
          CustomText(
            data:
                'A roomy backpack from the specialists in everyday bags at Herschel Supply Co., featuring resilient canvas and a light-blue patina that feels just right for summer.',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Colors.grey,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
