import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RatingRow extends StatelessWidget {
  final int stars;

  const RatingRow({super.key, required this.stars});

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterProvider>(context);
    final isSelected = filter.rating == stars;
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          filter.setRating(null);
        } else {
          filter.setRating(stars);
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: List.generate(stars, (index) {
                return const Icon(
                  Icons.star,
                  color: Color(0xFFFFB800),
                  size: 24,
                );
              }),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.black : Colors.grey[300],
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
