import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/admin/widgets/add_product_color_dialog.dart';
import 'package:batrina/views/product/admin/widgets/color_circle.dart';
import 'package:batrina/views/product/admin/widgets/edit_product_color_dialog.dart';
import 'package:batrina/widgets/build_dynamic_image.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ProductColorList extends StatefulWidget {
  const ProductColorList({super.key});

  @override
  State<ProductColorList> createState() => _ProductColorListState();
}

class _ProductColorListState extends State<ProductColorList> {
  void _showEditDialog(ProductColor productColor, int index) {
    ProductColor prl = productColor;
    final theme = Theme.of(context);
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: productFormProvider,
          child: Dialog(
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: EditProductColorDialog(productColor: prl, index: index),
          ),
        );
      },
    );
  }

  void _showAddDialog() {
    final theme = Theme.of(context);
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();
    showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: productFormProvider,
          child: Dialog(
            backgroundColor: theme.scaffoldBackgroundColor,
            shape: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(12.r),
            ),

            child: const AddProductColorDialog(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ProductFormProvider productFormProvider = context
        .watch<ProductFormProvider>();
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return Column(
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          onReorder: (oldIndex, newIndex) {
            productFormProvider.reorderColors(oldIndex, newIndex);
          },

          proxyDecorator: (child, index, animation) {
            return AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12.r),
                  child: child,
                );
              },
              child: child,
            );
          },
          itemCount: productFormProvider.product.availableColors.length,
          itemBuilder: (context, index) {
            final ProductColor productColor =
                productFormProvider.product.availableColors[index];
            final bool isLightColor =
                productColor.color.computeLuminance() > 0.5;

            return Container(
              key: ValueKey(productColor.colorCode),
              margin: EdgeInsets.only(bottom: 10.h),
              child: Material(
                color: Colors.transparent,

                child: InkWell(
                  onTap: () => _showEditDialog(productColor, index),
                  child: Container(
                    height: 75.h,
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.9.r,
                        color: isLightColor
                            ? Colors.grey.shade300
                            : productColor.color,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.drag_handle, color: Colors.grey[400]),
                        SizedBox(width: 10.w),

                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: productColor.images.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 5.w),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 50.w,
                                height: 50.h,
                                child: Material(
                                  borderRadius: BorderRadius.circular(12.r),
                                  clipBehavior: Clip.antiAlias,
                                  child: BuildDynamicImage(
                                    imageUrl: productColor.images[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        ColorCircle(productColor: productColor.color),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),

        InkWell(
          onTap: () => _showAddDialog(),
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: theme.primaryColor.withValues(alpha: 0.5),
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  color: theme.primaryColor,
                  size: 24.sp,
                ),
                SizedBox(width: 8.w),
                CustomText(
                  data: loc!.addNewColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  forceStrutHeight: true,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
