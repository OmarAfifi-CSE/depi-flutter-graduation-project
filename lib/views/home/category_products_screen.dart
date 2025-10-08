import 'package:batrina/controllers/provider/products_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/product/widgets/product_details.dart';
import 'package:batrina/routing/app_routes.dart';
import 'package:batrina/views/home/widgets/product_card_widget.dart';
import 'package:batrina/views/product/product_screen.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categoryName;

  const CategoryProductsScreen({super.key, required this.categoryName});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.refresh(widget.categoryName);
    }); // بنطلب أول دفعة

    // بنضيف Listener عشان نراقب السكرول
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // لما يوصل للآخر، بنطلب الدفعة التالية
        provider.fetchProducts(widget.categoryName);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  data: loc!.clothes,
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
                  itemCount:
                      provider.products.length + (provider.hasMore ? 2 : 0),
                  itemBuilder: (context, index) {
                    if (index >= provider.products.length) {
                      return null;
                    }
                    final product = provider.products[index];
                    return GestureDetector(
                      onTap: () async {
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
