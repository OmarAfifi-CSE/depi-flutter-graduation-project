import 'package:batrina/controllers/cubit/category/manage_category/manage_category_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/categories/admin/manage_category/widgets/option_item.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key});

  void _showUrlInputDialog(BuildContext context, ManageCategoryCubit cubit) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final TextEditingController urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: theme.scaffoldBackgroundColor,
          insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: CustomText(
            data: loc!.urlLink,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: TextField(
              controller: urlController,
              decoration: InputDecoration(
                hintText: "https://example.com/image.png",
                hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: theme.primaryColor),
                ),
                focusColor: theme.primaryColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: theme.primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: CustomText(
                data: loc.cancel,
                color: Colors.red,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                if (urlController.text.isNotEmpty) {
                  cubit.setImageUrl(urlController.text);
                  Navigator.pop(ctx);
                }
              },
              child: CustomText(
                data: loc.save,
                color: theme.scaffoldBackgroundColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                forceStrutHeight: true,
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddImageOptions(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final cubit = context.read<ManageCategoryCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) {
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
                  OptionItem(
                    icon: Icons.photo_library_outlined,
                    label: loc.gallery,
                    onTap: () {
                      Navigator.pop(context);
                      cubit.pickImage();
                    },
                  ),
                  OptionItem(
                    icon: Icons.link,
                    label: loc.urlLink,
                    onTap: () {
                      Navigator.pop(context);
                      _showUrlInputDialog(context, cubit);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return BlocBuilder<ManageCategoryCubit, ManageCategoryState>(
      buildWhen: (previous, current) {
        if (current is ManageCategoryUpdated) return true;
        return false;
      },
      builder: (context, state) {
        String? currentImage;
        if (state is ManageCategoryUpdated) {
          currentImage = state.image;
        }
        if (currentImage == null || currentImage.isEmpty) {
          return GestureDetector(
            onTap: () => _showAddImageOptions(context),
            child: Container(
              width: 150.w,
              height: 150.w,
              decoration: BoxDecoration(
                color: theme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: theme.primaryColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40.sp,
                    color: theme.primaryColor,
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    data: loc!.uploadImage,
                    fontSize: 12.sp,
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          );
        }

        return SizedBox(
          width: 150.w,
          height: 150.w,
          child: Stack(
            children: [
              Positioned.fill(
                child: Material(
                  borderRadius: BorderRadius.circular(16.r),
                  clipBehavior: Clip.antiAlias,
                  elevation: 2,
                  child: BuildDynamicImage(imageUrl: currentImage),
                ),
              ),
              Positioned(
                top: 5.h,
                right: 5.w,
                child: GestureDetector(
                  onTap: () =>
                      context.read<ManageCategoryCubit>().removeImage(),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Icon(Icons.close, color: Colors.white, size: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
