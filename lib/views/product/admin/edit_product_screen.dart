import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/admin/widgets/edit_button.dart';
import 'package:batrina/views/product/admin/widgets/product_color_list.dart';
import 'package:batrina/views/product/admin/widgets/product_information.dart';
import 'package:batrina/views/product/admin/widgets/variant_selector.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.productModel});

  final ProductModel? productModel;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => CategoryCubit()..fetchCategories()),
        ChangeNotifierProvider(
          create: (context) => ProductFormProvider()
            ..initProduct(widget.productModel)
            ..addMode = widget.productModel == null,
        ),
      ],

      child: Scaffold(
        appBar: AppBar(
          title: CustomHeaderWidget(
            prefix: const BackArrow(),
            center: CustomText(
              data: loc!.editProduct,
              textAlign: TextAlign.center,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: const SizedBox(),
          leadingWidth: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25.w),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 15.h),
                        CustomText(
                          data: loc.productColors,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 6.h),
                        const ProductColorList(),
                        SizedBox(height: 15.h),
                        const VariantSelector(),
                        SizedBox(height: 15.h),
                        const ProductInformation(),
                        SizedBox(height: 25.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                const EditButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
