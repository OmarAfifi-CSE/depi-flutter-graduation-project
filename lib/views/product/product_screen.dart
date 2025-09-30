import 'package:batrina/controllers/cubit/product/get_product_variants_cubit/get_product_variant_cubit.dart';
import 'package:batrina/controllers/cubit/product/product_reviews_cubit/get_product_reviews_cubit.dart';
import 'package:batrina/controllers/provider/control_rating_provider.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/views/product/widgets/product_images_slider.dart';
import 'package:batrina/views/product/widgets/product_options.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../l10n/app_localizations.dart';
import '../../styling/app_colors.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // context.read<ControlRatingProvider>().currentRating =
    //     widget.productModel.rating ?? 0.0;
    // context.read<ControlRatingProvider>().currentRatingCount =
    //     widget.productModel.reviewsCount ?? 0;
    //todo make provider out side
    context.read<ControlRatingProvider>().productModel = widget.productModel;
    super.initState();
  }

  double _currentSheetSize = 0.16;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;

    return BlocProvider(
      create: (context) =>
          GetProductVariantCubit()
            ..getProductVariants(productModel: widget.productModel),

      child: BlocBuilder<GetProductVariantCubit, GetProductVariantState>(
        builder: (context, state) {
          if (state is GetProductVariantFailure) {
            return const Scaffold(body: Center(child: Text("err")));
          } else if (state is GetProductVariantLoading) {
            return Scaffold(
              body: Center(
                child: CupertinoActivityIndicator(color: theme.primaryColor),
              ),
            );
          }
          final String? initColor = widget.productModel.availableColors.isEmpty
              ? null
              : widget.productModel.availableColors[0].colorCode;
          final String? initSize = widget.productModel.availableSizes.isEmpty
              ? null
              : widget.productModel.availableSizes[0];

          return ChangeNotifierProvider(
            create: (context) => ProductProvider(widget.productModel)
              ..currentColorName = initColor
              ..currentSize = initSize
              ..currentVariantStock = widget.productModel.getVariantStock(
                initColor ?? '',
                initSize ?? '',
              )
              ..currentSliderImage = widget.productModel.getImagesByColor(
                initColor ?? '',
              ),
            child: Scaffold(
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom:
                              constraints.maxHeight * _currentSheetSize - 20.h,
                          child: Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(),
                            child: ProductImagesSlider(
                              productModel: widget.productModel,
                            ),
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
                                    child: ProductOptions(
                                      productModel: widget.productModel,
                                    ),
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
            ),
          );
        },
      ),
    );
  }
}
