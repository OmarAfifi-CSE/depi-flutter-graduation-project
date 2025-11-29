import 'package:batrina/controllers/cubit/category/manage_category/manage_category_cubit.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/category_model.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/views/categories/admin/manage_category/widgets/image_selector.dart';
import 'package:batrina/views/categories/admin/widgets/confirmation_dialog.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ManageCategoryScreen extends StatelessWidget {
  const ManageCategoryScreen({super.key, this.categoryModel});

  final CategoryModel? categoryModel;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => ManageCategoryCubit()
        ..initForm(categoryModel)
        ..loc = loc,
      child: BlocListener<ManageCategoryCubit, ManageCategoryState>(
        listener: (context, state) {
          if (state is ManageCategorySuccess) {
            Navigator.pop(context);
            CustomSnackBar.showSnackBar(
              context: context,
              message: state.message ?? loc.savedSuccessfully,
              color: Colors.green,
            );
          } else if (state is ManageCategoryError) {
            CustomSnackBar.showSnackBar(
              context: context,
              message: state.message,
              color: Colors.red,
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (innerContext) {
                return CustomHeaderWidget(
                  prefix: const BackArrow(),
                  center: CustomText(
                    data: categoryModel == null
                        ? loc!.addCategory
                        : loc!.editCategory,
                    textAlign: TextAlign.center,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  suffix: categoryModel != null
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {
                              final cubit = innerContext
                                  .read<ManageCategoryCubit>();

                              ConfirmationDialog.show(
                                context,
                                title: loc.deleteCategory,
                                content: loc.areYouSureToDeleteCategory,
                                confirmText: loc.delete,
                                confirmButtonColor: Colors.red,
                                onConfirm: () {
                                  cubit.deleteCategory();
                                },
                              );
                            },
                            child: Container(
                              width: 35.w,
                              height: 35.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withValues(alpha: 0.1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.deleteIcon,
                                  width: 18.w,
                                  height: 18.w,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.red,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
            leading: const SizedBox(),
            leadingWidth: 0,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25.h),
                          const Center(child: ImageSelector()),
                          SizedBox(height: 30.h),
                          CustomText(
                            data: loc!.categoryName,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: 10.h),
                          Builder(
                            builder: (context) {
                              return TextFormField(
                                initialValue: categoryModel?.name,
                                cursorColor: theme.primaryColor,
                                onChanged: (val) {
                                  context
                                      .read<ManageCategoryCubit>()
                                      .updateName(val);
                                },
                                decoration: InputDecoration(
                                  hintText: loc.enterCategoryName,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide(
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  focusColor: theme.primaryColor,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: BorderSide(
                                      color: theme.primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                    borderSide: const BorderSide(
                                      color: Colors.red,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: theme.primaryColor),
                            ),
                            child:
                                BlocBuilder<
                                  ManageCategoryCubit,
                                  ManageCategoryState
                                >(
                                  buildWhen: (previous, current) {
                                    if (current is ManageCategoryUpdated)
                                      return true;
                                    return false;
                                  },
                                  builder: (context, state) {
                                    bool isActive = true;
                                    if (state is ManageCategoryUpdated) {
                                      isActive = state.isActive;
                                    } else if (categoryModel != null) {
                                      isActive = categoryModel!.isActive;
                                    }
                                    return InkWell(
                                      onTap: () {
                                        context
                                            .read<ManageCategoryCubit>()
                                            .toggleActive(!isActive);
                                      },
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            data: loc.isActive,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          Switch(
                                            value: isActive,
                                            activeThumbColor:
                                                theme.primaryColor,
                                            onChanged: (val) {
                                              context
                                                  .read<ManageCategoryCubit>()
                                                  .toggleActive(val);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child:
                        BlocBuilder<ManageCategoryCubit, ManageCategoryState>(
                          builder: (context, state) {
                            if (state is ManageCategoryLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: theme.primaryColor,
                                ),
                              );
                            }
                            return CustomElevatedButton(
                              onPressed: () {
                                context
                                    .read<ManageCategoryCubit>()
                                    .submitCategory();
                              },
                              backgroundColor: theme.primaryColor,
                              buttonChild: CustomText(
                                data: loc.save,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: theme.scaffoldBackgroundColor,
                              ),
                            );
                          },
                        ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
