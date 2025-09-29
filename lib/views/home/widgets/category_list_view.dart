import 'package:batrina/views/home/widgets/category_card_widget.dart' show CategoryCardWidget;
import 'package:flutter/material.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.separated(
          itemBuilder: (context, i) {
            return const CategoryCardWidget();
          },
          itemCount: 20,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
        ));
  }
}
