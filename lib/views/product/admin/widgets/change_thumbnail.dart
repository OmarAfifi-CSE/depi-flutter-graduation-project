import 'dart:convert';
import 'dart:typed_data';
import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/views/product/admin/widgets/add_image_text_field.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChangeThumbnail extends StatefulWidget {
  const ChangeThumbnail({Key? key}) : super(key: key);

  @override
  State<ChangeThumbnail> createState() => _ChangeThumbnailState();
}

class _ChangeThumbnailState extends State<ChangeThumbnail> {
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

  Future<void> pickImage() async {
    XFile? xFile = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 800,
      maxHeight: 800,
      source: ImageSource.gallery,
    );
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();
    if (xFile != null) {
      Uint8List uint8listImage = await xFile.readAsBytes();
      String encodedImage = base64Encode(uint8listImage);
      productFormProvider.setThumbNail(encodedImage);
    }
  }

  void _showUrlInputDialog() {
    final TextEditingController urlController = TextEditingController();
    final theme = Theme.of(context);
    GlobalKey<FormState> _formKey = GlobalKey();
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();
    final loc = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: productFormProvider,
          child: AlertDialog(
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.all(12.r),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    data: loc!.pasteImagesUrl,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20.h),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 400),
                    child: AddImageTextField(controller: urlController),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        buttonChild: CustomText(
                          data: loc.cancel,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.primaryColor,
                        ),
                        backgroundColor: theme.scaffoldBackgroundColor,
                        extend: true,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            productFormProvider.setThumbNail(
                              urlController.text.trim(),
                            );
                            Navigator.pop(context);
                          }
                        },
                        buttonChild: CustomText(
                          data: loc.save,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: theme.scaffoldBackgroundColor,
                        ),
                        backgroundColor: theme.primaryColor,
                        extend: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    ProductFormProvider productFormProvider = context
        .watch<ProductFormProvider>();
    final loc = AppLocalizations.of(context);
    return InkWell(
      onTap: () {
        _showAddImageOptions();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(12.r),
          border: Border.all(width: 1.1.r, color: theme.primaryColor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    data: loc!.productThumbnail,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    data: loc.mainImage,
                    fontSize: 11.sp,
                    color: appColors.secondaryText,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),

              productFormProvider.product.thumbnail.isNotEmpty
                  ? Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(12.r),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(12.r),
                        clipBehavior:
                            Clip.antiAlias, // This is the key property
                        child: BuildDynamicImage(
                          imageUrl: productFormProvider.product.thumbnail,
                        ),
                      ),
                    )
                  : Container(
                      width: 60.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusGeometry.circular(12.r),
                        color: theme.scaffoldBackgroundColor,
                        border: Border.all(
                          color: theme.primaryColor,
                          width: 1.1.r,
                        ),
                      ),
                      child: Center(
                        child: Icon(Icons.add, color: theme.primaryColor),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
