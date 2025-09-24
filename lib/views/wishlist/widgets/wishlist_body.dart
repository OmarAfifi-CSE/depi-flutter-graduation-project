import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/views/wishlist/widgets/search_bar.dart';
import 'package:batrina/views/wishlist/widgets/wishlist_tile.dart';

class WishlistBody extends StatelessWidget {
  const WishlistBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),

        // Search bar
        const WishListSearchBar(),
        const SizedBox(height: 20),

        // Wishlist title
        _buildWishlistTitle(),
        const SizedBox(height: 16),

        // Wishlist items
        Expanded(child: _buildWishlistItems()),
      ],
    );
  }
}

Widget _buildWishlistTitle() {
  return const Align(
    alignment: Alignment.centerLeft,
    child: CustomText(
      data: 'Wishlist',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}

Widget _buildWishlistItems() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return const WishlistCard();
    },
  );
}
