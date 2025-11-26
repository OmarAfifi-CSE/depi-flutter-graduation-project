import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/profile/wishlist/widgets/empty_wishlist.dart';
import 'package:batrina/views/profile/wishlist/widgets/no_product_found.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/profile/wishlist//widgets/wishlist_tile.dart';

class WishlistBody extends StatefulWidget {
  const WishlistBody({super.key});

  @override
  State<WishlistBody> createState() => _WishlistBodyState();
}

class _WishlistBodyState extends State<WishlistBody> {
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _allWishlistItems = [];
  List<ProductModel> _filteredWishlistItems = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterWishlist(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredWishlistItems = _allWishlistItems;
      } else {
        final lowerQuery = query.toLowerCase().trim();
        _filteredWishlistItems = _allWishlistItems
            .where(
              (product) =>
                  product.name.toLowerCase().contains(lowerQuery) ||
                  product.subtitle.toLowerCase().contains(lowerQuery) ||
                  product.price.toString().contains(lowerQuery),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        // Search bar
        _buildSearch(loc),
        SizedBox(height: 20.h),

        // Wishlist items
        Expanded(child: _buildWishlistItems()),
      ],
    );
  }

  //! Seach Bar
  Row _buildSearch(AppLocalizations? loc) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterWishlist,
              decoration: InputDecoration(
                hintText: '${loc!.search}...',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Colors.black, width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 15.h,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 50.w,
          height: 50.h,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.qr_code_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }

  //! Wishlist Items
  Widget _buildWishlistItems() {
    final theme = Theme.of(context);
    return FutureBuilder<List<ProductModel>>(
      future: FireBaseFireStore().getUserWishList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(color: theme.primaryColor),
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading wishlist.'));
        } else if (snapshot.hasData) {
          // Store all items when data is first loaded
          _allWishlistItems = snapshot.data!;
          // Initialize filtered items if not already done
          if (_filteredWishlistItems.isEmpty &&
              _searchController.text.isEmpty) {
            _filteredWishlistItems = _allWishlistItems;
          }

          // Handle empty wishlist
          if (_allWishlistItems.isEmpty) {
            return const EmptyWishlist();
          }

          // Handle no search results
          if (_filteredWishlistItems.isEmpty &&
              _searchController.text.isNotEmpty) {
            return const NoProductFoundView();
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _filteredWishlistItems.length,
            itemBuilder: (context, index) {
              return WishlistCard(product: _filteredWishlistItems[index]);
            },
          );
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
