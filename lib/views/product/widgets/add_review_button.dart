import 'package:batrina/controllers/cubit/product/add_review_cubit/add_review_cubit.dart';
import 'package:batrina/controllers/cubit/product/product_reviews_cubit/get_product_reviews_cubit.dart';
import 'package:batrina/controllers/provider/product_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/product/widgets/select_stars.dart';
import 'package:batrina/views/product/widgets/stars.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../controllers/cubit/product/add_button_control_cubit/add_button_control_cubit.dart';
import '../../../l10n/app_localizations.dart';
import '../../../styling/app_colors.dart';

class AddReviewButton extends StatefulWidget {
  const AddReviewButton({
    super.key,
    required this.textEditingController,
    required this.productModel,
  });
  final TextEditingController textEditingController;
  final ProductModel productModel;

  @override
  State<AddReviewButton> createState() => _AddReviewButtonState();
}

class _AddReviewButtonState extends State<AddReviewButton>
    with SingleTickerProviderStateMixin {
  late BuildContext savedContext;
  late AnimationController moveController;
  late Animation<double> topAnimation;
  late Animation<double> leftAnimation;
  ScrollController scrollController = ScrollController();

  bool isOpen = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    savedContext = context;
    moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    topAnimation = Tween<double>(
      begin: 44.h + MediaQuery.of(context).padding.top,
      end: 190.h,
    ).animate(CurvedAnimation(parent: moveController, curve: Curves.easeInOut));

    leftAnimation = Tween<double>(
      begin: 1.sw - 25.w - 35.w,
      end: 25.w,
    ).animate(CurvedAnimation(parent: moveController, curve: Curves.easeInOut));

    // نسمع حالة الانيميشن
    moveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => isOpen = true);
      }
      if (status == AnimationStatus.reverse ||
          status == AnimationStatus.dismissed) {
        setState(() => isOpen = false);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    moveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    return BlocProvider(
      create: (context) => AddReviewCubit(),
      child: AnimatedBuilder(
        animation: moveController,
        builder: (context, child) {
          return Positioned(
            top: topAnimation.value,
            left: leftAnimation.value,
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 1000),
              width: isOpen ? MediaQuery.of(context).size.width - 50.w : 35.h,
              height: isOpen ? 140.h : 35.h,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: isOpen
                    ? theme.scaffoldBackgroundColor
                    : theme.primaryColor,
                borderRadius: BorderRadiusGeometry.circular(
                  isOpen ? 12.r : 100.r,
                ),
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.black12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: isOpen
                  ? Material(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: TextFormField(
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: AppFonts.mainFontName,
                              ),
                              controller: widget.textEditingController,
                              autofocus: true,
                              expands: true,
                              maxLines: null,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintText: "Add Review...",
                                hintStyle: TextStyle(
                                  fontFamily: AppFonts.mainFontName,
                                  color: appColors.secondaryText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                                border: InputBorder.none,
                                // الأيقونة الشمال
                                prefixIcon:
                                    BlocConsumer<
                                      AddReviewCubit,
                                      AddReviewState
                                    >(
                                      listener: (context, state) {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((
                                              timeStamp,
                                            ) async {
                                              if (state is AddReviewSuccess &&
                                                  isOpen == true) {
                                                setState(() {
                                                  isOpen = false;
                                                });
                                                await Future.delayed(
                                                  const Duration(
                                                    milliseconds: 1000,
                                                  ),
                                                );
                                                savedContext
                                                    .read<
                                                      GetProductReviewsCubit
                                                    >()
                                                    .getReviews(
                                                      widget.productModel,
                                                    );
                                                savedContext
                                                    .read<
                                                      AddButtonControlCubit
                                                    >()
                                                    .makeItClose();
                                                widget.textEditingController
                                                    .clear();
                                                moveController.reverse();
                                              }
                                            });
                                      },
                                      builder: (context, state) {
                                        return GestureDetector(
                                          onTap: state is! AddReviewLoading
                                              ? () {
                                                  print(
                                                    FireBaseFireStore
                                                        .currentUser
                                                        ?.name,
                                                  );
                                                  //Todo
                                                  if (widget
                                                      .textEditingController
                                                      .text
                                                      .isNotEmpty) {
                                                    context
                                                        .read<AddReviewCubit>()
                                                        .addReview(
                                                          reviewModel: ReviewModel(
                                                            id: "",

                                                            userId: FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            userName: "amr",
                                                            rating: SelectStars
                                                                .numberOfStart
                                                                .toDouble(),
                                                            comment: widget
                                                                .textEditingController
                                                                .text
                                                                .trim(),
                                                            userImage: null,
                                                            createdAt:
                                                                DateTime.now(),
                                                          ),
                                                          productModel: widget
                                                              .productModel,
                                                        );
                                                  }
                                                }
                                              : () {},
                                          child: state is! AddReviewLoading
                                              ? Icon(
                                                  Icons.add,
                                                  size: 20.sp,
                                                  color: theme.primaryColor,
                                                )
                                              : CupertinoActivityIndicator(
                                                  color: theme.primaryColor,
                                                ),
                                        );
                                      },
                                    ),
                                prefixIconConstraints: BoxConstraints(
                                  minWidth: 40.w,
                                  minHeight: 40.h,
                                ),

                                // الأيقونة اليمين
                                suffixIcon: GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isOpen = false;
                                    });
                                    await Future.delayed(
                                      const Duration(milliseconds: 1000),
                                    );
                                    context
                                        .read<AddButtonControlCubit>()
                                        .makeItClose();
                                    widget.textEditingController.clear();
                                    moveController.reverse();
                                  },
                                  child: Icon(
                                    Icons.close,
                                    size: 22.sp,
                                    color: theme.primaryColor,
                                  ),
                                ),
                                suffixIconConstraints: BoxConstraints(
                                  minWidth: 40.w,
                                  minHeight: 40.h,
                                ),
                              ),
                            ),
                          ),
                          SelectStars()
                              .animate(delay: Duration(milliseconds: 1000))
                              .fadeIn(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              ),
                          SizedBox(height: 5.h),
                        ],
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        context.read<AddButtonControlCubit>().makeItOpen();
                        moveController.forward();
                      },
                      child: Icon(
                        Icons.add,
                        size: 20.sp,
                        color: theme.scaffoldBackgroundColor,
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
