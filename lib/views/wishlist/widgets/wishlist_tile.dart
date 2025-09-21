import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';

class WishlistCard extends StatelessWidget {
  const WishlistCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
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
    child: Row(
      children: [
        // Product image
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.grey[200],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/images.jpeg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Product details
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                data: 'title',

                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              SizedBox(height: 4),
              CustomText(
                data: 'productName',

                fontSize: 14,

                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(height: 8),
              CustomText(
                data: '\$213',

                fontSize: 16,
                fontWeight: FontWeight.bold,

                color: Colors.black,
              ),
            ],
          ),
        ),

        // Add to cart button
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(18),
          ),
          child: TextButton(
            onPressed: () {},
            child: const CustomText(
              data: 'Add to cart',
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
  }
}