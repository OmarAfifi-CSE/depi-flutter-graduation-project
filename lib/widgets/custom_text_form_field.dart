import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  bool obscureText;
  final String labelText;
  final String? Function(String? value) validator;
  final bool enabled;
  final Widget? suffixIcon;

  CustomTextFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.labelText,
    required this.validator,
    this.enabled = true,
    this.suffixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;
  bool isValid = false;
  TextDirection? _textDirection;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    isValid = widget.validator(widget.controller.text) == null;


  }

  @override
  void dispose() {
    super.dispose();
  }

  TextDirection? _getTextDirection(String text,BuildContext context) {
    if (text.isEmpty) {
      if (AppLocalizations.of(context)?.localeName == 'ar') {
        _textDirection =TextDirection.rtl;
      }else{
        _textDirection =TextDirection.ltr;
      }
      return _textDirection;
    }
    // Simple regex to check for Arabic characters in the Unicode range
    final RegExp arabicRegex = RegExp(r'[\u0600-\u06FF]');

    // Check the first character
    if (arabicRegex.hasMatch(text[0])) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  toggleObscure() {
    if (!mounted) return;
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  Widget? _buildValidationIcon(ThemeData theme) {
    if (isValid) {
      return Icon(Icons.check_circle, color: theme.primaryColor)
          .animate(key: const ValueKey('check_icon'))
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
            duration: 800.ms,
            curve: Curves.elasticOut,
          );
    }
    if (widget.controller.text.isNotEmpty) {
      return const Icon(Icons.cancel, color: Colors.red)
          .animate(key: const ValueKey('cancel_icon'))
          .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1, 1),
            duration: 800.ms,
            curve: Curves.elasticOut,
          );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      onChanged: (text) {
        if (!mounted) return;
        setState(() {
          _textDirection = _getTextDirection(text, context);
          if (!widget.obscureText) {
            isValid = widget.validator(text) == null;
          }
        });
      },
      textDirection: _textDirection,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: widget.enabled,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isObscured,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        suffixIcon:
            widget.suffixIcon ??
            (widget.obscureText
                ? _buildPasswordIcon(context)
                : _buildValidationIcon(theme)),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.cardColor),
        ),
        focusColor: theme.primaryColor,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
        label: Text(
          widget.labelText,
          style: TextStyle(color: theme.primaryColor),
        ),
      ),
      style: TextStyle(
        color: theme.primaryColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.mainFontName,
      ),
    );
  }

  Widget _buildPasswordIcon(BuildContext context) {
    final theme = Theme.of(context);
    return IconButton(
      icon: _isObscured
          ? Icon(Icons.visibility_off, color: theme.primaryColor)
                .animate(key: const ValueKey('show_icon'))
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 800.ms,
                  curve: Curves.elasticOut,
                )
          : Icon(Icons.visibility, color: theme.primaryColor)
                .animate(key: const ValueKey('hide_icon'))
                .scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1, 1),
                  duration: 800.ms,
                  curve: Curves.elasticOut,
                ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
    );
  }
}
