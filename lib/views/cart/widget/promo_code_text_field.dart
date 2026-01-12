import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/cart/widget/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromoCodeTextField extends StatefulWidget {
  const PromoCodeTextField({super.key});

  @override
  State<PromoCodeTextField> createState() => _PromoCodeTextFieldState();
}

class _PromoCodeTextFieldState extends State<PromoCodeTextField> {
  final TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);
    return SizedBox(
      height: 50.h,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: theme.primaryColor.withValues(alpha: .15),
              blurRadius: 10,
              offset: Offset(0, 2.h),
              spreadRadius: 1,
            ),
          ],
        ),
        child: TextField(
          controller: textEditingController,
          style: TextStyle(
            fontFamily: AppFonts.englishFontFamily,
            color: theme.primaryColor,
            fontSize: 16.sp,
          ),
          cursorColor: theme.primaryColor,
          decoration: InputDecoration(
            contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 18.w),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10.r),
            ),
            hintText: loc!.promoCode,
            hintStyle: TextStyle(
              fontFamily: AppFonts.mainFontName,
              color: appColors.textField,
              fontSize: 16.sp,
            ),
            filled: true,
            fillColor: appColors.textFieldFill,
            suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(160.w)),
            suffixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 18.w),
              child: ApplyButton(textEditingController: textEditingController),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: theme.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
