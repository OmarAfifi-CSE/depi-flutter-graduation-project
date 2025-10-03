import 'package:batrina/models/review_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/product/widgets/stars.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReviewWidget extends StatefulWidget {
  const ReviewWidget({super.key, required this.reviewModel});

  final ReviewModel reviewModel;

  @override
  State<ReviewWidget> createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12.r),
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: .15),
            blurRadius: 10,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(8.r),
            ),
            child: widget.reviewModel.userImage != null
                ? Material(
                    // This provides the high-performance clipping
                    borderRadius: BorderRadius.circular(12.r),
                    clipBehavior: Clip.antiAlias, // This is the key property
                    child: BuildDynamicImage(
                      imageUrl: widget.reviewModel.userImage!,
                    ),
                  )
                : Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusGeometry.circular(12.r),
                      image: const DecorationImage(
                        image: NetworkImage(
                          "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),

          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 145.w,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            data: widget.reviewModel.userName,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        CustomText(
                          data: widget.reviewModel.createdAt != null
                              ? DateFormat(
                                  'dd MMM, yyyy',
                                  Localizations.localeOf(context).languageCode,
                                ).format(widget.reviewModel.createdAt!)
                              : 'Unknown date',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.secondaryText,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 80.w,
                      child: Stars(
                        numberOfStart: widget.reviewModel.rating.toInt(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                CustomText(
                  textAlign: TextAlign.start,
                  data: widget.reviewModel.comment,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
