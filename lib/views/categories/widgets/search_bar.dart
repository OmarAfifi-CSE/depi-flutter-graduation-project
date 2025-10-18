import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String)? onChanged;

  const SearchBarWidget({super.key, this.onChanged});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Padding(
      padding: EdgeInsets.only(left: 25.w, right: 16.w,),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
                color: theme.primaryColor.withValues(alpha: .15),
                blurRadius: 10,
                offset: Offset(0, 2.h),
                spreadRadius: 1
            ),
          ],
        ),
        child: TextField(
          controller: _controller,
          onChanged: widget.onChanged,
          style: TextStyle(color: theme.primaryColor, fontSize: 16),
          cursorColor: theme.primaryColor,
          decoration: InputDecoration(
            hintText: loc!.search,
            hintStyle: TextStyle(color: appColors.textField, fontSize: 16.sp),
            filled: true,
            fillColor: appColors.textFieldFill,
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 26.w, right: 16.w),
              child: SvgPicture.asset(
                AppAssets.searchIcon,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  appColors.textField!,
                  BlendMode.srcIn,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 80.w,
              maxWidth: 80.w,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14.h),
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
