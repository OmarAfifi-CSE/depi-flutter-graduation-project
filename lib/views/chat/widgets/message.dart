import 'package:batrina/models/chat_page_models/message_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class Message extends StatelessWidget {
  const Message({super.key, required this.messageModel, required this.isMe});
  final MessageModel messageModel;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>();

    if (messageModel.type == "image") {
      final List<String> parts = messageModel.text.split('\n');
      final String part1 = parts.isNotEmpty ? parts[0] : '';
      final String part2 = parts.length > 1 ? parts.skip(1).join('\n') : '';
      return GestureDetector(
        onTap: () {
          context.pushNamed(
            AppRoutes.productScreen,
            pathParameters: {'productId': ?messageModel.pId},
          );
        },
        child: Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 1.sw / 2,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isMe ? appColors?.dividerColor : theme.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(isMe ? 20.r : 0),
                bottomRight: Radius.circular(isMe ? 0 : 20.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 120.h,
                  child: Material(
                    borderRadius: BorderRadius.circular(12.r),
                    clipBehavior: Clip.antiAlias, // This is the key property
                    child: BuildDynamicImage(
                      imageUrl: messageModel.imageUrl ?? "",
                    ),
                  ),
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  data: part1,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: isMe
                      ? theme.primaryColor
                      : theme.scaffoldBackgroundColor,
                ),
                CustomText(
                  textAlign: TextAlign.start,
                  data: part2,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: isMe
                      ? theme.primaryColor
                      : theme.scaffoldBackgroundColor,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints.loose(Size.fromWidth(1.sw / 2 + 100.w)),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: isMe ? appColors?.dividerColor : theme.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: Radius.circular(isMe ? 20.r : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20.r),
          ),
        ),
        child: CustomText(
          textAlign: TextAlign.start,
          data: messageModel.text,
          fontSize: 15.sp,
          fontWeight: FontWeight.w400,
          color: isMe ? theme.primaryColor : theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
