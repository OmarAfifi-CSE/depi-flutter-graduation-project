import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationTextField extends StatelessWidget {
  const InformationTextField({
    super.key,
    required this.textEditingController,
    required this.validator,
    this.isEmail = false,
    required this.hint,
    required this.title,
    this.onChanges,
  });
  final TextEditingController textEditingController;
  final String? Function(String? value) validator;
  final bool isEmail;
  final String hint;
  final String title;

  final void Function(String? value)? onChanges;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomText(data: title, fontSize: 12.sp, fontWeight: FontWeight.w400),
        SizedBox(height: 5.h),
        Directionality(
          textDirection: TextDirection.ltr,
          child: TextField(
            controller: textEditingController,
            maxLines: isEmail ? 5 : 2,
            minLines: isEmail ? 1 : 1,
            keyboardType: isEmail ? TextInputType.multiline : null,
            style: TextStyle(
              fontFamily: AppFonts.englishFontFamily,
              color: theme.primaryColor,
              fontSize: 14.sp,
            ),
            onChanged: onChanges,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: AppFonts.englishFontFamily,
                color: theme.dividerColor,
                fontSize: 12.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(12.r)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
