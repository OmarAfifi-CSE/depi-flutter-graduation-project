import 'dart:convert';

import 'package:batrina/models/review_model.dart';
import 'package:batrina/views/product/widgets/stars.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../l10n/app_localizations.dart';
import '../../../styling/app_colors.dart';

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
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12.r),
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: .15),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
                ? _buildImage(widget.reviewModel.userImage!)
                : ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(8.r),
                    child: Image.network(
                      "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                      fit: BoxFit.cover,
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

  Widget _buildImage(String imageUrl) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final isNetworkImage =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    print(isNetworkImage);
    if (isNetworkImage) {
      return ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,

          fadeInDuration: const Duration(milliseconds: 500),
          fadeOutDuration: const Duration(milliseconds: 500),
          placeholder: (context, url) => Container(
            color: appColors.card,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[400],
              size: 48,
            ),
          ),
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(8.r),
        child: Image.memory(
          base64Decode(imageUrl),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,

          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[200],
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[400],
              size: 48,
            ),
          ),
        ),
      );
    }
  }
}
