import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/widgets/product/empty_category_widget.dart';
import 'package:batrina/widgets/product/product_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProductGridView extends StatelessWidget {
  final String categoryName;

  const ProductGridView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final theme = Theme.of(context);
    return provider.products.isEmpty && !provider.isLoading
        ? Center(child: EmptyCategoryWidget(categoryName: categoryName))
        : Directionality(
            textDirection: TextDirection.ltr,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 18.w,
                mainAxisSpacing: 20.h,
              ),
              itemCount: provider.products.length + (provider.hasMore ? 2 : 0),
              itemBuilder: (context, index) {
                if (index >= provider.products.length) {
                  return Center(
                    child: CupertinoActivityIndicator(
                      color: theme.primaryColor,
                    ),
                  );
                }
                final product = provider.products[index];
                return GestureDetector(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.categoryProductScreen,
                      pathParameters: {
                        'categoryName': categoryName,
                        'productId': product.id,
                      },
                    );
                  },
                  child: ProductCardWidget(
                    price: product.price,
                    finalPrice: product.finalPrice,
                    discountPercentage: product.discountPercentage,
                    name: product.name,
                    subtitle: product.subtitle,
                    img: product.thumbnail,
                  ),
                );
              },
            ),
          );
  }
}
