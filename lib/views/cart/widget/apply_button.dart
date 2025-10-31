import 'package:batrina/controllers/cubit/cart/check_promo_code_cubit/check_promo_code_cubit.dart';
import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyButton extends StatefulWidget {
  const ApplyButton({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  bool showResult = false;
  int lastTextLength = 0;
  @override
  void initState() {
    widget.textEditingController.addListener(() {
      if (lastTextLength != widget.textEditingController.text.length) {
        context.read<CartPriceProvider>().setDiscount(dis: 0);

        setState(() {
          showResult = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => CheckPromoCodeCubit(),
      child: BlocListener<CheckPromoCodeCubit, CheckPromoCodeState>(
        listener: (context, state) {
          if (state is CheckPromoCodeSuccess) {
            CartPriceProvider cartPriceProvider = context
                .read<CartPriceProvider>();

            if (state.promoCodeModel != null) {
              cartPriceProvider.setDiscount(
                dis: state.promoCodeModel!.calculateDiscount(
                  cartPriceProvider.subTotal,
                ),
              );
            } else {
              cartPriceProvider.setDiscount(dis: 0);
            }
            setState(() {
              showResult = true;
            });
          }
        },
        child: BlocBuilder<CheckPromoCodeCubit, CheckPromoCodeState>(
          builder: (context, state) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color:
                    showResult &&
                        state is CheckPromoCodeSuccess &&
                        state.promoCodeModel != null
                    ? Colors.green
                    : showResult &&
                          state is CheckPromoCodeSuccess &&
                          state.promoCodeModel == null
                    ? Colors.red
                    : theme.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: GestureDetector(
                onTap: state is! CheckPromoCodeLoading
                    ? () {
                        context.read<CheckPromoCodeCubit>().isDiscounted(
                          code: widget.textEditingController.text,
                        );
                        lastTextLength =
                            widget.textEditingController.text.length;
                      }
                    : null,
                child: state is CheckPromoCodeLoading
                    ? CupertinoActivityIndicator(
                        color: theme.scaffoldBackgroundColor,
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child:
                            showResult &&
                                state is CheckPromoCodeSuccess &&
                                state.promoCodeModel != null &&
                                state.promoCodeModel!.isValid
                            ? Row(
                                key: const ValueKey('success'),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: theme.scaffoldBackgroundColor,
                                    size: 18.sp,
                                  ),
                                ],
                              )
                            : showResult &&
                                  state is CheckPromoCodeSuccess &&
                                  state.promoCodeModel == null
                            ? Row(
                                key: const ValueKey('error'),
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: theme.scaffoldBackgroundColor,
                                    size: 18.sp,
                                  ),
                                ],
                              )
                            : CustomText(
                                key: const ValueKey('normal'),
                                data: "Apply",
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                                color: theme.scaffoldBackgroundColor,
                              ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
