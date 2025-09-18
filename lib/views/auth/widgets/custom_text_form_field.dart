import 'package:batrina/styling/app_fonts.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  bool obscureText;
  final String labelText;
  final String? Function(String? value) validator;

  CustomTextFormField({
    super.key,
    required this.controller,
    this.obscureText = false,
    required this.labelText,
    required this.validator,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
    if (!widget.obscureText) {
      widget.controller.addListener(() {
        setState(() {
          if (widget.validator(widget.controller.text) == null) {
            isValid = true;
          } else {
            isValid = false;
          }
        });
      });
    }
  }

  toggleObscure() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isObscured,
      cursorColor: theme.primaryColor,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText
            ? _buildPasswordIcon(context)
            : isValid
            ? const Icon(Icons.check_circle)
            : const Icon(Icons.cancel, color: Colors.red),
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
      icon: Icon(
        _isObscured ? Icons.visibility_off : Icons.visibility,
        color: theme.primaryColor,
      ),
      onPressed: () {
        setState(() {
          _isObscured = !_isObscured;
        });
      },
    );
  }
}
