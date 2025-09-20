import 'package:flutter/material.dart';

class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({super.key, this.suffix, this.center, this.prefix});
  final Widget? suffix;
  final Widget? center;
  final Widget? prefix;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        prefix != null
            ? Align(alignment: Alignment.centerLeft, child: prefix)
            : const SizedBox.shrink(),
        center != null
            ? Align(alignment: Alignment.center, child: center)
            : const SizedBox.shrink(),
        suffix != null
            ? Align(alignment: Alignment.centerRight, child: suffix)
            : const SizedBox.shrink(),
      ],
    );
  }
}
