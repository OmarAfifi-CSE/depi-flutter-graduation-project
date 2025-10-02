import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/views/product/widgets/product_images_slider.dart';
import 'package:batrina/views/product/widgets/product_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  double _currentSheetSize = 0.16;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = context.watch<ProductProvider>().productModel;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: constraints.maxHeight * _currentSheetSize - 20.h,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: ProductImagesSlider(productModel: product),
                  ),
                ),
                // الـ DraggableScrollableSheet
                NotificationListener<DraggableScrollableNotification>(
                  onNotification: (notification) {
                    setState(() {
                      _currentSheetSize = notification.extent;
                    });
                    return true;
                  },
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.16,
                    minChildSize: 0.16,
                    maxChildSize: 0.6,
                    snap: true,
                    snapSizes: const [0.16, 0.6],
                    builder: (context, scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: theme.primaryColor.withValues(
                                alpha: .15,
                              ),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 25.w,
                            right: 25.w,
                            top: 25.h,
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            controller: scrollController,
                            child: ProductOptions(productModel: product),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
