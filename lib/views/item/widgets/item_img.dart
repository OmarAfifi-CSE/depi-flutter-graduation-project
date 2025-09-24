import 'package:flutter/material.dart';

class ItemImg extends StatelessWidget {
  const ItemImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main product image
        SizedBox(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * .4,
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
            width: 40,
            height: 40,
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
