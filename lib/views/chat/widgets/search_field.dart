import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
  });
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final FocusNode? focusNode;
  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          height: 50.h,
          child: TextField(
            onChanged: widget.onChanged,
            controller: widget.controller,
            expands: true,
            maxLines: null,
            style: TextStyle(
              fontFamily: AppFonts.englishFontFamily,
              color: theme.primaryColor,
              fontSize: 14.sp,
            ),

            decoration: InputDecoration(
              hintText: loc!.search,
              hintStyle: TextStyle(
                fontFamily: AppFonts.mainFontName,
                color: theme.dividerColor,
                fontSize: 14.sp,
              ),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: appColors.textField!,
                  width: 1.2.w,
                ),
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
              ),
              prefixIcon: Container(
                padding: EdgeInsetsGeometry.only(right: 15.w),
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  AppAssets.searchIcon,
                  colorFilter: ColorFilter.mode(
                    theme.primaryColor,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.scaleDown,
                ),
              ),
              prefixIconConstraints: BoxConstraints.loose(Size.fromWidth(60.w)),
            ),
          ),
        ),
      ),
    );
  }
}
