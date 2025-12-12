import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVariantOption extends StatefulWidget {
  const AddVariantOption({
    super.key,
    required this.colorCode,
    this.productVariant,
  });
  final String colorCode;
  final ProductVariant? productVariant;
  @override
  State<AddVariantOption> createState() => _AddVariantOptionState();
}

class _AddVariantOptionState extends State<AddVariantOption> {
  TextEditingController quantityController = TextEditingController();
  String? selectedSize;
  int quantity = 0;

  @override
  void initState() {
    if (widget.productVariant != null) {
      quantityController = TextEditingController(
        text: widget.productVariant!.stock.toString(),
      );
      selectedSize = widget.productVariant!.size;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductFormProvider productFormProvider = context
        .read<ProductFormProvider>();
    String variantType = productFormProvider.selectedVariantType;
    List<String> availableSizes =
        productFormProvider.availableSizesForVariantType;
    final theme = Theme.of(context);
    final appColors = theme.extension<AppColorTheme>()!;
    final loc = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.all(20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.productVariant == null)
            CustomText(
              data:
                  "${loc!.add} ${variantType == 'Clothing'
                      ? loc.size
                      : variantType == 'Numeric'
                      ? loc.number
                      : loc.stock}",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          SizedBox(height: 20.h),

          if (variantType == 'Clothing' || variantType == 'Numeric')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data:
                      "${loc!.select} ${variantType == 'Clothing' ? loc!.size : loc!.number}",
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                DropdownButton<String>(
                  dropdownColor: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(8.r),
                  menuMaxHeight: 150.h,
                  menuWidth: 200.w,
                  isExpanded: true,

                  hint: CustomText(
                    data: loc.choose,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  value: selectedSize,
                  items: availableSizes.map((size) {
                    return DropdownMenuItem(
                      value: size,
                      child: CustomText(
                        data: size,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSize = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
              ],
            ),

          CustomText(
            data: loc!.quantity,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: quantityController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: loc.enterQuantity,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appColors.textField!),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appColors.textField!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: appColors.textField!),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 10.h,
              ),
            ),
            onChanged: (value) {
              setState(() {
                quantity = int.tryParse(value) ?? 0;
              });
            },
          ),
          SizedBox(height: 20.h),

          Row(
            children: [
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  buttonChild: CustomText(
                    data: loc.cancel,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    color: theme.scaffoldBackgroundColor,
                  ),
                  backgroundColor: theme.primaryColor,
                  extend: true,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: () {
                  int currentQuantity =
                      int.tryParse(quantityController.text) ?? 0;

                  bool isValidInput =
                      (selectedSize != null || variantType == 'Standard') &&
                      currentQuantity > 0;

                  bool sizeChanged =
                      selectedSize != widget.productVariant?.size;
                  bool quantityChanged =
                      currentQuantity != widget.productVariant?.stock;

                  bool hasChanges =
                      isValidInput &&
                      (widget.productVariant == null ||
                          sizeChanged ||
                          quantityChanged);
                  return CustomElevatedButton(
                    onPressed: hasChanges
                        ? () {
                            if (widget.productVariant == null) {
                              Navigator.pop(context);
                              productFormProvider.addVariantForColor(
                                widget.colorCode,
                                selectedSize ?? "Standard",
                                quantity,
                              );
                            } else {
                              productFormProvider.updateVariant(
                                widget.productVariant!,
                                ProductVariant(
                                  id: "",
                                  color: widget.colorCode,
                                  size: selectedSize ?? "Standard",
                                  stock: quantity,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          }
                        : null,
                    buttonChild: CustomText(
                      data: widget.productVariant == null ? loc.add : loc.edit,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: theme.scaffoldBackgroundColor,
                    ),
                    backgroundColor: theme.primaryColor,
                    extend: true,
                  );
                }(),
              ),
            ],
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}
