import 'dart:convert';

import 'package:batrina/styling/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BuildDynamicImage extends StatelessWidget {
  final String imageUrl;

  const BuildDynamicImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    final isNetworkImage =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
    if (isNetworkImage) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,

        fadeInDuration: const Duration(milliseconds: 500),
        fadeOutDuration: const Duration(milliseconds: 500),
        placeholder: (context, url) => Container(
          color: appColors.card,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Theme.of(context).primaryColor,
            ),
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
        width: double.infinity,
        height: double.infinity,
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
