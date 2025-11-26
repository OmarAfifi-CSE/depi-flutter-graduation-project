import 'dart:convert';

import 'package:batrina/styling/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuildDynamicImage extends StatelessWidget {
  final String imageUrl;

  const BuildDynamicImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final isNetworkImage =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
        placeholder: (context, url) => Container(
          color: appColors.dividerColor,
          child: Center(
            child: CupertinoActivityIndicator(color: theme.primaryColor),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey[400],
            size: 48,
          ),
        ),
      );
    } else {
      return Image.memory(
        base64Decode(imageUrl),
        fit: BoxFit.cover,
        width: width,
        height: height,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey[200],
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey[400],
            size: 48,
          ),
        ),
      );
    }
  }
}
