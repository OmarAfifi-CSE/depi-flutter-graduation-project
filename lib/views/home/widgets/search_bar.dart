import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarWidget extends StatefulWidget {
  final String placeholder;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color hintColor;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const SearchBarWidget({
    super.key,
    this.placeholder = 'Search',
    this.onChanged,
    this.onSubmitted,
    this.controller,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.iconColor = const Color(0xFF9E9E9E),
    this.textColor = Colors.black87,
    this.hintColor = const Color(0xFF9E9E9E),
    this.borderRadius = 30,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(0),
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context);
      final loc = AppLocalizations.of(context);
      final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        style: TextStyle(
          color: widget.textColor,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: loc!.search,
          hintStyle: TextStyle(
            color: widget.hintColor,
            fontSize: 16.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: widget.iconColor,
            size: 20,
          ),
          border: InputBorder.none,
          contentPadding: widget.padding,
        ),
      ),
    );
  }
}
