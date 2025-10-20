import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider;

class PriceSlider extends StatelessWidget {
  const PriceSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterProvider>(context);
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.black,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.white,
            overlayColor: Colors.black.withOpacity(0.1),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12,
              elevation: 2,
            ),
            trackHeight: 3,
          ),
          child: RangeSlider(
            values: Provider.of<FilterProvider>(context).priceRange ,
            min: 0,
            max: 1750,
            divisions: 35,
            onChanged: filter.setPriceRange,
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${filter.priceRange.start.toInt()}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '\$${filter.priceRange.end.toInt()}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$1750',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
