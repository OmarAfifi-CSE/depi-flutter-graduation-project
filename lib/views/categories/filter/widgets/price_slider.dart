import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart' show Provider;

class PriceSlider extends StatelessWidget {
  const PriceSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final filter = Provider.of<FilterProvider>(context);
    return Column(
      children: [
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: theme.primaryColor,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: theme.primaryColor,
            overlayColor: Colors.black.withOpacity(0.1),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12,
              elevation: 2,
            ),
            trackHeight: 3,
          ),
          child: RangeSlider(
            values: Provider.of<FilterProvider>(context).priceRange,
            min: 0,
            max: 1750,
            divisions: 35,
            onChanged: filter.setPriceRange,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                data: '\$${filter.priceRange.start.toInt()}',
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              CustomText(
                data: '\$${filter.priceRange.end.toInt()}',
                fontSize: 14,
                fontWeight: FontWeight.w600,
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
