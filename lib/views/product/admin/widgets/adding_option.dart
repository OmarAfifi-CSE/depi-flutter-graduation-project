import 'dart:convert';
import 'dart:typed_data';

import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/product/admin/widgets/add_images_url.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddingOption extends StatefulWidget {
  const AddingOption({Key? key, required this.images, required this.refresh})
    : super(key: key);
  final List<String> images;
  final void Function() refresh;

  @override
  State<AddingOption> createState() => _AddingOptionState();
}

class _AddingOptionState extends State<AddingOption> {
  void _showAddImageOptions() {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                data: loc!.addImageFrom,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildOptionItem(
                    icon: Icons.photo_library_outlined,
                    label: loc.gallery,
                    onTap: () {
                      Navigator.pop(context); // اقفل الشيت
                      pickImage(); // افتح الجاليري
                    },
                  ),
                  _buildOptionItem(
                    icon: Icons.link,
                    label: loc.urlLink,
                    onTap: () {
                      Navigator.pop(context); // اقفل الشيت
                      _showUrlInputDialog(); // افتح دايالوج اللينك
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOptionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            child: Icon(icon, size: 30.sp, color: theme.primaryColor),
          ),
          SizedBox(height: 8.h),
          CustomText(data: label, fontSize: 14.sp, fontWeight: FontWeight.w500),
        ],
      ),
    );
  }

  void _showUrlInputDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddImagesUrl(images: widget.images, refresh: widget.refresh);
      },
    );
  }

  Future<void> pickImage() async {
    List<XFile> xFiles = await ImagePicker().pickMultiImage(
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (xFiles.isNotEmpty) {
      List<Uint8List> uint8listImages = [];
      for (XFile xFile in xFiles) {
        uint8listImages.add(await xFile.readAsBytes());
      }
      List<String> encodedImages = [];
      for (Uint8List uint8listImage in uint8listImages) {
        String encodedImage = base64Encode(uint8listImage);
        encodedImages.add(encodedImage);
      }
      for (String encodedImage in encodedImages) {
        if (!widget.images.contains(encodedImage)) {
          widget.images.add(encodedImage);
        }
      }
      widget.refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ProductFormProvider>();
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorTheme>()!;
    return GestureDetector(
      onTap: _showAddImageOptions,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(12.r),
          border: Border.all(color: appColors.dividerColor!, width: 1.1.r),
        ),
        child: Center(child: Icon(Icons.add, color: appColors.dividerColor)),
      ),
    );
  }
}
