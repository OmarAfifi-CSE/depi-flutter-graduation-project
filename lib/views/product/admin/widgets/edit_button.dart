import 'package:batrina/controllers/cubit/admin/add_edit_product_cubit/add_edit_product_cubit.dart';
import 'package:batrina/controllers/provider/product_form_provide.dart';
import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/widgets/custom_elevated_button.dart';
import 'package:batrina/widgets/custom_snack_bar.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EditButton extends StatelessWidget {
  const EditButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    ProductFormProvider productFormProvider = context
        .watch<ProductFormProvider>();
    final bool isNewProduct = productFormProvider.product.id.isEmpty;
    final bool canSave =
        (productFormProvider.hasChanges || isNewProduct) &&
        productFormProvider.isValid;
    return BlocProvider(
      create: (context) => AddEditProductCubit(),
      child: BlocConsumer<AddEditProductCubit, AddEditProductState>(
        listener: (context, state) {
          if (state is AddEditProductSuccess) {
            if (productFormProvider.addMode) {
              context.pop(productFormProvider.product);
              context.read<ProductsProvider>().refreshSameCategory();
            } else {
              context.pop(productFormProvider.product);
              context.read<ProductsProvider>().refreshSameCategory();
            }
            CustomSnackBar.showSnackBar(
              context: context,
              message: productFormProvider.addMode
                  ? loc!.productAddedSuccessfully
                  : loc!.productEditedSuccessfully,
              color: Colors.green,
            );
          } else if (state is AddEditProductFailure) {
            CustomSnackBar.showSnackBar(
              context: context,
              message: state.error,
              color: Colors.green,
            );
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              Expanded(
                flex: 2,
                child: CustomElevatedButton(
                  onPressed: canSave
                      ? () {
                          context.pushNamed(
                            AppRoutes.productScreen,
                            pathParameters: {"productId": "anyThing"},
                            extra: productFormProvider.product,
                          );
                        }
                      : null,
                  buttonChild: CustomText(
                    data: loc!.preview,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    forceStrutHeight: true,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 3,
                child: CustomElevatedButton(
                  onPressed: canSave
                      ? () {
                          if (state is! AddEditProductLoading) {
                            context.read<AddEditProductCubit>().addEditProduct(
                              productFormProvider.product,
                            );
                          }
                        }
                      : null,
                  buttonChild: state is AddEditProductLoading
                      ? CupertinoActivityIndicator(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        )
                      : CustomText(
                          data: productFormProvider.addMode
                              ? loc.addProduct
                              : loc.editProduct,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          forceStrutHeight: true,
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
