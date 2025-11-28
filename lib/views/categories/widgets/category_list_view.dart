import 'dart:ui';
import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/categories/admin/manage_category/add_category_card.dart';
import 'package:batrina/views/categories/admin/widgets/confirmation_dialog.dart';
import 'package:batrina/views/categories/widgets/category_card_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  bool isReorderMode = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final isAdmin = FireBaseFireStore.currentUser?.isAdmin ?? false;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isAdmin)
          Padding(
            padding: EdgeInsets.only(right: 25.w, left: 25.w, bottom: 0.h),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              switchInCurve: Curves.easeInOutQuart,
              switchOutCurve: Curves.easeInOutQuart,
              // عشان نضمن ان مفيش تغيير في الحجم يحصل أثناء الحركة
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    ...previousChildren,
                    if (currentChild != null) currentChild,
                  ],
                );
              },
              transitionBuilder: (Widget child, Animation<double> animation) {
                final isRtl = Directionality.of(context) == TextDirection.rtl;
                final isReorderWidget =
                    (child.key as ValueKey<String>).value == 'reorder_mode';

                double offsetX = isReorderWidget ? 1.0 : -1.0;
                if (isRtl) {
                  offsetX = -offsetX;
                }

                final offset = Offset(offsetX, 0.0);
                final offsetAnimation = Tween<Offset>(
                  begin: offset,
                  end: Offset.zero,
                ).animate(animation);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },

              child: isReorderMode
                  ? SizedBox(
                      height: 60.h,
                      key: const ValueKey('reorder_mode'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                isReorderMode = false;
                              });
                              context.read<CategoryCubit>().fetchCategories(
                                isAdmin: isAdmin,
                              );
                            },
                            icon: const Icon(Icons.close, color: Colors.red),
                            label: CustomText(
                              data: loc!.cancel,
                              color: Colors.red,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              ConfirmationDialog.show(
                                context,
                                title: loc.saveChanges,
                                content: loc.areYouSureToSaveCategoryOrder,
                                onConfirm: () {
                                  context
                                      .read<CategoryCubit>()
                                      .saveOrderToFirebase();
                                  setState(() {
                                    isReorderMode = false;
                                  });

                                  CustomSnackBar.showSnackBar(
                                    context: context,
                                    message:
                                        loc.categoryOrderUpdatedSuccessfully,
                                    color: Colors.green,
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.primaryColor,
                              foregroundColor: theme.scaffoldBackgroundColor,
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.check),
                            label: CustomText(
                              data: loc.save,
                              color: theme.scaffoldBackgroundColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 60.h,
                      key: const ValueKey('normal_mode'),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isReorderMode = true;
                              });
                            },
                            child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.sort_rounded,
                                    color: theme.primaryColor,
                                  ),
                                  SizedBox(width: 8.w),
                                  CustomText(
                                    data: loc!.reorderCategories,
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),

        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            switch (state) {
              case CategoryLoading() || CategoryInitial():
                return const Expanded(
                  child: Center(child: CupertinoActivityIndicator()),
                );

              case CategoryError():
                return Expanded(child: Center(child: Text(state.message)));

              case CategorySuccess():
                if (state.categories.isEmpty && !isAdmin) {
                  return Expanded(
                    child: Center(child: Text(loc!.emptyCategories)),
                  );
                }
                if (isAdmin && isReorderMode) {
                  return Expanded(
                    child: ReorderableListView.builder(
                      padding: EdgeInsets.only(bottom: 20.h),
                      itemCount: state.categories.length,
                      proxyDecorator: (child, index, animation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (BuildContext context, Widget? child) {
                            final double animValue = Curves.easeInOut.transform(
                              animation.value,
                            );
                            final double scale = lerpDouble(
                              1,
                              1.03,
                              animValue,
                            )!;
                            final double opacity = lerpDouble(
                              0,
                              0.5,
                              animValue,
                            )!;
                            final double blur = lerpDouble(0, 20, animValue)!;
                            final double leftPad = lerpDouble(
                              0,
                              20,
                              animValue,
                            )!;
                            final double rightPad = lerpDouble(
                              0,
                              20,
                              animValue,
                            )!;
                            final double topPad = lerpDouble(0, 20, animValue)!;
                            final double bottomPad = lerpDouble(
                              0,
                              5,
                              animValue,
                            )!;

                            return Transform.scale(
                              scale: scale,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: leftPad,
                                    right: rightPad,
                                    top: topPad,
                                    bottom: bottomPad,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: theme.primaryColor
                                                .withValues(alpha: opacity),
                                            blurRadius: blur,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  child!,
                                ],
                              ),
                            );
                          },
                          child: child,
                        );
                      },

                      onReorder: (oldIndex, newIndex) {
                        context.read<CategoryCubit>().reorderLocally(
                          oldIndex,
                          newIndex,
                        );
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          key: ValueKey(state.categories[index].id),
                          margin: EdgeInsets.only(bottom: 16.h),
                          child: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              CategoryCardWidget(
                                category: state.categories[index],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10.w,
                                      sigmaY: 10.h,
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: theme.primaryColor.withValues(
                                          alpha: 0.3,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.drag_indicator_rounded,
                                        color: theme.scaffoldBackgroundColor,
                                        size: 24.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return Expanded(
                  child: ListView.separated(
                    itemCount: state.categories.length + (isAdmin ? 1 : 0),
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    padding: EdgeInsets.only(bottom: 20.h),
                    itemBuilder: (context, i) {
                      if (isAdmin && i == state.categories.length) {
                        return const AddCategoryCard();
                      }
                      return CategoryCardWidget(category: state.categories[i]);
                    },
                  ),
                );
            }
          },
        ),
      ],
    );
  }
}
