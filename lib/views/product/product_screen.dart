import 'package:batrina/controllers/cubit/product/get_product_cubit/get_product_cubit.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/widgets/product_details.dart';
import 'package:batrina/views/product/widgets/product_not_found_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:batrina/widgets/custom_text.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({
    super.key,
    required this.productId,
    this.size,
    this.color,
    this.previewModel,
    this.updateItem,
  });
  final ProductModel? previewModel;

  final String productId;
  // If coming from cart
  final String? size;
  final String? color;
  final void Function(ProductModel? pr, BuildContext context)? updateItem;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool preview = widget.previewModel != null;
    print(widget.previewModel);

    return !preview
        ? BlocProvider(
            create: (context) =>
                GetProductCubit()..getProduct(productId: widget.productId),
            child: BlocBuilder<GetProductCubit, GetProductState>(
              builder: (context, state) {
                if (state is GetProductLoading) {
                  return Scaffold(
                    body: Center(
                      child: CupertinoActivityIndicator(
                        color: theme.primaryColor,
                      ),
                    ),
                  );
                }
                if (state is GetProductFailure) {
                  return Center(
                    child: CustomText(
                      data: state.error,
                      fontSize: 23.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }
                final product = (state as GetProductSuccess).productModel;
                if (widget.updateItem != null) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    widget.updateItem!(product, context);
                  });
                }
                if (product == null) {
                  return const Scaffold(
                    body: Center(child: ProductNotFoundView()),
                  );
                }

                return ChangeNotifierProvider(
                  create: (context) =>
                      ProductProvider(productModel: product)
                        ..initialize(size: widget.size, color: widget.color),
                  child: const ProductDetails(),
                );
              },
            ),
          )
        : ChangeNotifierProvider(
            create: (context) =>
                ProductProvider(productModel: widget.previewModel!)
                  ..preview = preview
                  ..initialize(size: widget.size, color: widget.color),
            child: const ProductDetails(),
          );
  }
}
