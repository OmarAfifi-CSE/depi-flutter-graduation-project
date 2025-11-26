import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddImageTextField extends StatefulWidget {
  const AddImageTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.AddAnotherField,
    this.removeField,
    this.index = 0,
  });

  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final int index;
  final FocusNode? focusNode;
  final void Function()? AddAnotherField;
  final void Function(int index)? removeField;

  @override
  State<AddImageTextField> createState() => _AddImageTextFieldState();
}

class _AddImageTextFieldState extends State<AddImageTextField> {
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
          child: TextFormField(
            onChanged: widget.onChanged,
            controller: widget.controller,
            focusNode: widget.focusNode,

            maxLines: 1,
            style: TextStyle(
              fontFamily: AppFonts.englishFontFamily,
              color: theme.primaryColor,
              fontSize: 10.sp,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return loc!.pleaseEnterUrl;
              }
              String pattern =
                  r'^(http|https):\/\/'
                  r'([\w-]+\.)+[\w-]+'
                  r'(\/[\w- ./?%&=]*)?$';
              RegExp regExp = RegExp(pattern);
              if (!regExp.hasMatch(value.trim())) {
                return loc!.invalidUrl;
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: "https://example.com/image.png",
              hintStyle: TextStyle(
                fontFamily: AppFonts.englishFontFamily,
                color: theme.dividerColor,
                fontSize: 10.sp,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 10.h,
              ),

              suffixIcon: _buildSuffixActions(theme),
              suffixIconConstraints: BoxConstraints(
                minWidth: 40.w,
                minHeight: 40.h,
              ),

              border: _buildBorder(appColors.textField!),
              enabledBorder: _buildBorder(appColors.textField!),
              disabledBorder: _buildBorder(appColors.textField!),
              focusedBorder: _buildBorder(appColors.textField!),
            ),
          ),
        ),
      ),
    );
  }

  Widget? _buildSuffixActions(ThemeData theme) {
    final bool showAdd = widget.AddAnotherField != null;
    final bool showRemove = widget.removeField != null;

    if (showAdd && showRemove) {
      return Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRemoveButton(),
            SizedBox(width: 8.w),
            _buildAddButton(theme),
          ],
        ),
      );
    } else if (showAdd) {
      return Padding(
        padding: EdgeInsets.all(6.r),
        child: _buildAddButton(theme),
      );
    } else if (showRemove) {
      return Padding(padding: EdgeInsets.all(6.r), child: _buildRemoveButton());
    }

    return null;
  }

  Widget _buildAddButton(ThemeData theme) {
    return InkWell(
      onTap: widget.AddAnotherField,
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.add,
          color: theme.scaffoldBackgroundColor,
          size: 18.sp,
        ),
      ),
    );
  }

  Widget _buildRemoveButton() {
    return InkWell(
      onTap: () => widget.removeField!(widget.index),
      child: Container(
        width: 30.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.close, color: Colors.red, size: 18.sp),
      ),
    );
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.2.w),
      borderRadius: BorderRadius.all(Radius.circular(12.r)),
    );
  }
}
