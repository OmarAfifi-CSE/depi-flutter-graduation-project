import 'package:batrina/controllers/cubit/product/add_button_control_cubit/add_button_control_cubit.dart';
import 'package:batrina/controllers/cubit/product/add_review_cubit/add_review_cubit.dart';
import 'package:batrina/controllers/cubit/product/product_reviews_cubit/get_product_reviews_cubit.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:batrina/styling/app_colors.dart';
import 'package:batrina/styling/app_fonts.dart';
import 'package:batrina/views/product/widgets/select_stars.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  late AnimationController moveController;
  late Animation<double> topAnimation;
  late Animation<double> leftAnimation;
  final ScrollController scrollController = ScrollController();
  bool _isInit = true;
  bool isOpen = false;
  bool _showContent = false;

  late final AddReviewCubit _addReviewCubit;

  @override
  void initState() {
    super.initState();
    _addReviewCubit = AddReviewCubit();

    moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      topAnimation =
          Tween<double>(
            begin: 44.h + MediaQuery.of(context).padding.top,
            end: 190.h,
          ).animate(
            CurvedAnimation(parent: moveController, curve: Curves.easeInOut),
          );

      leftAnimation = Tween<double>(begin: 1.sw - 25.w - 35.w, end: 25.w)
          .animate(
            CurvedAnimation(parent: moveController, curve: Curves.easeInOut),
          );

      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    moveController.dispose();
    scrollController.dispose();
    _addReviewCubit.close();
    super.dispose();
  }

  Future<void> _startCloseSequence() async {
    if (!isOpen && !_showContent) return;

    final addButtonControlCubit = context.read<AddButtonControlCubit>();
    const contentFadeDuration = Duration(milliseconds: 200);
    const containerShrinkDuration = Duration(milliseconds: 600);

    setState(() => _showContent = false);
    widget.textEditingController.clear();
    await Future.delayed(contentFadeDuration);
    if (!mounted) return;

    setState(() => isOpen = false);
    await Future.delayed(containerShrinkDuration);
    if (!mounted) return;

    await moveController.reverse();
    if (!mounted) return;

    addButtonControlCubit.makeItClose();
  }

  void _submitReview() {
    if (widget.textEditingController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      // Use the single instance of the cubit
      _addReviewCubit.addReview(
        reviewModel: ReviewModel(
          id: "",
          userId: FirebaseAuth.instance.currentUser!.uid,
          userName: FireBaseFireStore.currentUser?.name ?? "User",
          rating: SelectStars.numberOfStart.toDouble(),
          comment: widget.textEditingController.text.trim(),
          createdAt: DateTime.now(),
        ),
        productModel: widget.productModel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);
    final appColors = Theme.of(context).extension<AppColorTheme>()!;
    const containerAnimationDuration = Duration(milliseconds: 600);
    const placeholderShrinkDuration = Duration(milliseconds: 300);

    return BlocProvider.value(
      value: _addReviewCubit,
      child: AnimatedBuilder(
        animation: moveController,
        builder: (context, child) {
          return Positioned(
            top: topAnimation.value,
            left: leftAnimation.value,
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              duration: containerAnimationDuration,
              width: isOpen ? MediaQuery.of(context).size.width - 50.w : 35.h,
              height: isOpen ? 280.h : 35.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isOpen
                    ? theme.scaffoldBackgroundColor
                    : theme.primaryColor,
                borderRadius: BorderRadius.circular(isOpen ? 16.r : 100.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: isOpen ? 15 : 5,
                    color: theme.primaryColor.withValues(
                      alpha: isOpen ? 0.15 : 0,
                    ),
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isOpen
                  ? AnimatedOpacity(
                      opacity: _showContent ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    loc!.addReviewTitle,
                                    style: TextStyle(
                                      fontFamily: AppFonts.mainFontName,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30.w,
                                    height: 30.h,
                                    child: IconButton(
                                      onPressed: _startCloseSequence,
                                      icon: Icon(
                                        Icons.close_rounded,
                                        size: 18.sp,
                                      ),
                                      color: theme.primaryColor,
                                      style: IconButton.styleFrom(
                                        backgroundColor: theme.primaryColor
                                            .withValues(alpha: 0.1),
                                      ),
                                      padding: EdgeInsets.zero,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              TextFormField(
                                controller: widget.textEditingController,
                                autofocus: true,
                                maxLines: 5,
                                style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 14.sp,
                                ),
                                decoration: InputDecoration(
                                  hintText: loc.experienceHint,
                                  hintStyle: TextStyle(
                                    fontFamily: AppFonts.mainFontName,
                                    color: appColors.secondaryText,
                                    fontSize: 13.sp,
                                  ),
                                  filled: true,
                                  fillColor: theme.primaryColor.withValues(
                                    alpha: 0.05,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w,
                                    vertical: 10.h,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              BlocListener<AddReviewCubit, AddReviewState>(
                                listener: (context, state) async {
                                  if (state is AddReviewSuccess) {
                                    final getProductReviewsCubit = context
                                        .read<GetProductReviewsCubit>();
                                    await _startCloseSequence();
                                    await Future.delayed(
                                      placeholderShrinkDuration,
                                    );
                                    if (mounted) {
                                      getProductReviewsCubit.getReviews(
                                        widget.productModel,
                                      );
                                    }
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SelectStars(),
                                    BlocBuilder<AddReviewCubit, AddReviewState>(
                                      builder: (context, state) {
                                        bool isLoading =
                                            state is AddReviewLoading;
                                        return FilledButton.icon(
                                          onPressed: isLoading
                                              ? null
                                              : _submitReview,
                                          style: FilledButton.styleFrom(
                                            backgroundColor: theme.primaryColor,
                                            foregroundColor:
                                                theme.scaffoldBackgroundColor,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                            ),
                                          ),
                                          icon: isLoading
                                              ? const SizedBox.shrink()
                                              : Icon(
                                                  Icons.send_rounded,
                                                  size: 16.sp,
                                                ),
                                          label: isLoading
                                              ? SizedBox(
                                                  width: 20.w,
                                                  height: 20.h,
                                                  child:
                                                      const CircularProgressIndicator(
                                                        strokeWidth: 2.5,
                                                        color: Colors.white,
                                                      ),
                                                )
                                              : CustomText(
                                                  data: loc.postButton,
                                                  color: theme
                                                      .scaffoldBackgroundColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        context.read<AddButtonControlCubit>().makeItOpen();
                        await moveController.forward();
                        if (!mounted) return;
                        setState(() => isOpen = true);
                        await Future.delayed(containerAnimationDuration);
                        if (!mounted) return;
                        setState(() => _showContent = true);
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
