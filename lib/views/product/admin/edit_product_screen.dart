import 'package:batrina/controllers/cubit/admin/admin_mode/admin_mode_cubit.dart';
import 'package:batrina/controllers/cubit/category/category_cubit.dart';
import 'package:batrina/controllers/cubit/product/delete_product_cubit/delete_product_cubit.dart';
import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/styling/app_assets.dart';
import 'package:batrina/views/categories/admin/widgets/confirmation_dialog.dart';
import 'package:batrina/views/product/admin/widgets/edit_button.dart';
import 'package:batrina/views/product/admin/widgets/product_color_list.dart';
import 'package:batrina/views/product/admin/widgets/product_information.dart';
import 'package:batrina/views/product/admin/widgets/variant_selector.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
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
    final isAdmin = context.read<AdminModeCubit>().state;
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              CategoryCubit()..fetchCategories(isAdmin: isAdmin),
        ),
        BlocProvider(create: (context) => DeleteProductCubit()),
        ChangeNotifierProvider(
          create: (context) => ProductFormProvider()
            ..initProduct(widget.productModel)
            ..addMode = widget.productModel == null,
        ),
      ],

      child: BlocListener<DeleteProductCubit, DeleteProductState>(
        listener: (context, state) {
          if (state is DeleteProductLoading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  backgroundColor: Colors.white70,
                  content: SizedBox(
                    height: 150.h,
                    child: Center(
                      child: CupertinoActivityIndicator(
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is DeleteProductSuccess) {
            context.pop();
            CustomSnackBar.showSnackBar(
              context: context,
              message: loc.productDeletedSuccessfully,
              color: Colors.green,
            );
            context.goNamed(AppRoutes.splashScreen);
          } else if (state is DeleteProductFailure) {
            context.pop();
            CustomSnackBar.showSnackBar(
              context: context,
              message: state.error,
              color: Colors.green,
            );
            context.goNamed(AppRoutes.splashScreen);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Builder(
              builder: (innerContext) {
                return CustomHeaderWidget(
                  prefix: const BackArrow(),
                  center: CustomText(
                    data: widget.productModel == null
                        ? loc!.addProduct
                        : loc!.editProduct,
                    textAlign: TextAlign.center,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  suffix: widget.productModel != null
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            customBorder: const CircleBorder(),
                            onTap: () {
                              DeleteProductCubit deleteProductCubit =
                                  innerContext.read<DeleteProductCubit>();
                              showDialog(
                                context: innerContext,
                                builder: (dialogContext) {
                                  return BlocProvider.value(
                                    value: deleteProductCubit,
                                    child: ConfirmationDialog(
                                      title: loc.deleteProduct,
                                      content: loc.areYouSureToDeleteProduct,
                                      confirmText: loc.delete,
                                      confirmButtonColor: Colors.red,
                                      onConfirm: () {
                                        innerContext
                                            .read<DeleteProductCubit>()
                                            .deleteProduct(
                                              widget.productModel!.id,
                                            );
                                      },
                                    ),
                                  );
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
                            data: loc!.productColors,
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
                  SizedBox(height: 10.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
