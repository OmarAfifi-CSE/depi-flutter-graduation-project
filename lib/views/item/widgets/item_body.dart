import 'package:flutter/material.dart';
import 'package:batrina/views/item/widgets/item_img.dart';
import 'package:batrina/views/item/widgets/item_title.dart';
import 'package:batrina/views/item/widgets/add_to_card_btn.dart';

class ItemBody extends StatelessWidget {
  const ItemBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        // Product image section
        SliverToBoxAdapter(child: ItemImg()),

        // Product details card
        SliverToBoxAdapter(child: ItemDetails()),

        // Fixed bottom bar
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: AddToCardBtn(),
          ),
        ),
      ],
    );
  }
}
