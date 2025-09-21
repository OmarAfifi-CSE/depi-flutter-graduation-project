import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';

class AddToCardBtn extends StatelessWidget {
  const AddToCardBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      children: [
        // Price
        const CustomText(
          data: '\$245.00',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        const Spacer(),

        // Add to cart button
        GestureDetector(
          onTap: (){
            //TODO
          },
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_bag_outlined, color: Colors.black, size: 20),
                SizedBox(width: 8),
                CustomText(
                  data: 'Add to cart',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  }
}
