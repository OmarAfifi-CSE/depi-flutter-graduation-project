import 'package:flutter/material.dart';
import 'package:batrina/views/wishlist/widgets/wishlist_body.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: WishlistBody(),
      ),
    );
  }
}
