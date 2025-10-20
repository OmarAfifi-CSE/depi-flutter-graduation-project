import 'package:flutter/material.dart';
import 'package:batrina/views/item/widgets/item_img.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:batrina/views/item/widgets/item_details.dart';
import 'package:batrina/views/item/widgets/add_to_card_btn.dart';

class ItemBody extends StatelessWidget {
  const ItemBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Product image section
        const SliverToBoxAdapter(child: ItemImg()),

        // Product details card
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: const ItemDetails(),
          ),
        ),

        // Fixed bottom bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const AddToCardBtn(),
          ),
        ),
      ],
    );
  }
}
