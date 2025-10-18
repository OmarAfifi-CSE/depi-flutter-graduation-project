import 'package:batrina/controllers/cubit/product/get_product_cubit/get_product_cubit.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/cart_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/widgets/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../widgets/custom_text.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId, this.cartModel});

  final String productId;

  //لو جاي من كارت
  final CartModel? cartModel;

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
    final loc = AppLocalizations.of(context);

    return BlocProvider(
      create: (context) =>
          GetProductCubit()..getProduct(productId: widget.productId),
      child: BlocBuilder<GetProductCubit, GetProductState>(
        builder: (context, state) {
          if (state is GetProductLoading) {
            return Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(color: theme.primaryColor),
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

          return ChangeNotifierProvider(
            create: (context) => ProductProvider(productModel: product!)
              ..initialize(
                size: widget.cartModel?.size,
                color: widget.cartModel?.color,
              ),
            child: const ProductDetails(),
          );
        },
      ),
    );
  }
}
