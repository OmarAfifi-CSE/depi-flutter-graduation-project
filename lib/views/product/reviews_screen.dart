import 'package:batrina/controllers/cubit/product/add_button_control_cubit/add_button_control_cubit.dart';
import 'package:batrina/controllers/cubit/product/product_reviews_cubit/get_product_reviews_cubit.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/views/product/widgets/add_review_button.dart';
import 'package:batrina/views/product/widgets/review_widget.dart';
import 'package:batrina/widgets/back_arrow.dart';
import 'package:batrina/widgets/custom_header_widget.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  final TextEditingController reviewFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final productModel = context.read<ProductProvider>().productModel;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetProductReviewsCubit()..getReviews(productModel),
        ),
        BlocProvider(create: (context) => AddButtonControlCubit()),
      ],
      child: Stack(
        children: [
          Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 44.h),
                    const CustomHeaderWidget(prefix: BackArrow()),
                    SizedBox(height: 32.h),
                    CustomText(
                      data: loc!.reviewsHeader,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    BlocBuilder<AddButtonControlCubit, AddButtonControlState>(
                      builder: (context, state) {
                        double height;
                        if (state is AddButtonControlClose) {
                          height = 0;
                        } else {
                          height = 280.h;
                        }
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: height,
                        );
                      },
                    ),
                    SizedBox(height: 15.h),
                    Expanded(
                      child:
                          BlocListener<
                            GetProductReviewsCubit,
                            GetProductReviewsState
                          >(
                            listener: (context, state) {
                              if (state is GetProductReviewsSuccess) {
                                context.read<ProductProvider>().updateRating(
                                  state.reviews,
                                );
                              }
                            },
                            child:
                                BlocBuilder<
                                  GetProductReviewsCubit,
                                  GetProductReviewsState
                                >(
                                  builder: (context, state) {
                                    if (state is GetProductReviewsFailure) {
                                      return Center(
                                        child: CustomText(
                                          data: loc.reviewsLoadingError,
                                          fontSize: 21,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      );
                                    }

                                    if (state is GetProductReviewsSuccess) {
                                      final reviews = state.reviews;
                                      return reviews.isNotEmpty
                                          ? ListView.separated(
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                return ReviewWidget(
                                                  reviewModel: reviews[index],
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      SizedBox(height: 18.h),
                                              itemCount: reviews.length,
                                            )
                                          : Center(
                                              child: CustomText(
                                                data: loc.noReviewsYet,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            );
                                    }
                                    // هذه الحالة تغطي GetProductReviewsInitial و GetProductReviewsLoading
                                    return Center(
                                      child: CupertinoActivityIndicator(
                                        color: theme.primaryColor,
                                      ),
                                    );
                                  },
                                ),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AddReviewButton(
            textEditingController: reviewFieldController,
            productModel: productModel,
          ),
        ],
      ),
    );
  }
}
