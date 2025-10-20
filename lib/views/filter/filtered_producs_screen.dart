import 'package:batrina/controllers/provider/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../controllers/provider/products_provider.dart';
import '../../l10n/app_localizations.dart';
import '../../routing/app_routes.dart';
import '../../widgets/custom_text.dart';
import '../home/widgets/product_card_widget.dart';

class FilteredProductsScreen extends StatefulWidget {
  const FilteredProductsScreen({super.key});

  @override
  State<FilteredProductsScreen> createState() => _FilteredProductsScreenState();
}

class _FilteredProductsScreenState extends State<FilteredProductsScreen> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.fetchFilteredProducts(
        filterProvider.selectedCategories,
        filterProvider.priceRange.start,
        filterProvider.priceRange.end,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : provider.filteredProducts.isEmpty
            ? Center(
                child: CustomText(
                  data: loc!.noProductsFound,
                  fontSize: 18.sp, fontWeight: FontWeight.bold,
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25.w,
                    vertical: 25.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        data: loc!.filteredProducts,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(height: 18.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          crossAxisSpacing: 18.w,
                          mainAxisSpacing: 20.h,
                        ),
                        // عدد العناصر هو عدد المنتجات + 2 لو لسه فيه تحميل
                        itemCount: provider.filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = provider.filteredProducts[index];
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                AppRoutes.productScreen,
                                extra: product.id,
                              );
                            },
                            child: ProductCardWidget(
                              price: product.price,
                              name: product.name,
                              subtitle: product.subtitle,
                              img: product.thumbnail,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
