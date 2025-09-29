import 'package:flutter/material.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/wishlist/widgets/search_bar.dart';
import 'package:batrina/views/wishlist/widgets/wishlist_tile.dart';

class WishlistBody extends StatelessWidget {
  const WishlistBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search bar
        const WishListSearchBar(),
        SizedBox(height: 20.h),

        // Wishlist title
        _buildWishlistTitle(context),
        SizedBox(height: 20.h),

        // Wishlist items
        Expanded(child: _buildWishlistItems()),
      ],
    );
  }
}

Widget _buildWishlistTitle(BuildContext context) {
  final loc = AppLocalizations.of(context);
  return Align(
    alignment: Alignment.centerLeft,
    child: CustomText(
      data: loc!.favorites,
      fontSize: 24.sp,
      fontWeight: FontWeight.bold,
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
