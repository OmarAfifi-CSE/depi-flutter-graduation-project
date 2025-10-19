import 'dart:convert';
import 'dart:typed_data';
import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:batrina/widgets/build_dynamic_image.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late String? currentImage;
  ImagePicker imagePicker = ImagePicker();
  late ProfileProvider profileProvider;

  @override
  void initState() {
    profileProvider = context.read<ProfileProvider>();
    currentImage = profileProvider.currentImage;
    super.initState();
  }

  Future<void> pickImage() async {
    XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (xFile != null) {
      Uint8List uint8listImage = await xFile.readAsBytes();
      String encodedImage = base64Encode(uint8listImage);
      setState(() {
        currentImage = encodedImage;
      });
      profileProvider.setImage(encodedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: 6.h, right: 6.w),
              child: currentImage != null
                  ? Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(12.r),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(12.r),
                        clipBehavior:
                            Clip.antiAlias, // This is the key property
                        child: BuildDynamicImage(imageUrl: currentImage!),
                      ),
                    )
                  : Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(12.r),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://as2.ftcdn.net/v2/jpg/00/64/67/63/1000_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: 25.w,
                  height: 25.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusGeometry.circular(8.r),
                    color: theme.scaffoldBackgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withValues(alpha: .15),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.edit,
                    color: theme.primaryColor,
                    size: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        TextButton.icon(
          onPressed: () {
            pickImage();
          },
          icon: Icon(Icons.camera_alt_outlined, color: theme.primaryColor),
          label: CustomText(
            data: loc!.uploadImage,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
