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
      child: TextField(
        style: TextStyle(
          fontFamily: AppFonts.englishFontFamily,
          color: theme.primaryColor,
        ),
        controller: textEditingController,
        maxLines: null,
        expands: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 18.w),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.r),
          ),
          hintText: loc!.promoCode,
          fillColor: appColors.dividerColor,
          filled: true,
          hintStyle: TextStyle(
            fontFamily: AppFonts.mainFontName,
            color: appColors.textField,
          ),

          suffixIconConstraints: BoxConstraints.loose(Size.fromWidth(100.w)),
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 18.w),
            child: ApplyButton(textEditingController: textEditingController),
          ),
        ),
      ),
    );
  }
}
