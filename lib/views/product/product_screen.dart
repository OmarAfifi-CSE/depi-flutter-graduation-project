import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/widgets/product_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<ProductModel?> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = FireBaseFireStore().getProductWithVariants(
      productID: widget.productId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FutureBuilder<ProductModel?>(
      future: _productFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CupertinoActivityIndicator(color: theme.primaryColor),
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text("Error happened!"));
        }
        final product = snapshot.data!;
        return ChangeNotifierProvider(
          create: (context) => ProductProvider(productModel: product)..initialize(),
          child: const ProductDetails(),
        );
      },
    );
  }
}
