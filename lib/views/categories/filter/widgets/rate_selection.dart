import 'package:batrina/views/categories/filter/widgets/rating_row.dart';
import 'package:flutter/material.dart';

class RateSelection extends StatelessWidget {
  const RateSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
         RatingRow(stars: 5),
         SizedBox(height: 12),
         RatingRow(stars: 4),
         SizedBox(height: 12),
         RatingRow(stars: 3),
         SizedBox(height: 12),
         RatingRow(stars: 2),
      ],
    );
  }
}
