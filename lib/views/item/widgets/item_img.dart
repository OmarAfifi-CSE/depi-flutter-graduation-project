import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemImg extends StatelessWidget {
  const ItemImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main product image
        SizedBox(
          width: double.infinity,
          height: 400.h,
          child: Image.asset(
            'assets/images/images.jpeg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: const Icon(Icons.image, color: Colors.grey, size: 50),
              );
            },
          ),
        ),

        // Wishlist button
        Positioned(
          bottom: 20,
          right: 20,
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey[300] ?? Colors.grey),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
