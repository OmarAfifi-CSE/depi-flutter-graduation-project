import 'package:batrina/controllers/cubit/cart/check_promo_code_cubit/check_promo_code_cubit.dart';
import 'package:batrina/controllers/provider/cart_price_provider.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ApplyButtonStatus { idle, loading, success, invalid, error }

class ApplyButton extends StatefulWidget {
  const ApplyButton({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  bool _showResult = false;
  String _lastText = "";

  @override
  void initState() {
    super.initState();
    _lastText = widget.textEditingController.text;
    widget.textEditingController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (!mounted) return;
    if (widget.textEditingController.text != _lastText) {
      _lastText = widget.textEditingController.text;
      if (_showResult) {
        context.read<CartPriceProvider>().setDiscount(dis: 0);
        setState(() {
          _showResult = false;
        });
      }
    }
  }

  ApplyButtonStatus _getStatus(CheckPromoCodeState state) {
    if (state is CheckPromoCodeLoading) return ApplyButtonStatus.loading;

    if (_showResult) {
      if (state is CheckPromoCodeFailure) return ApplyButtonStatus.error;

      if (state is CheckPromoCodeSuccess) {
        final isValid =
            state.promoCodeModel != null && state.promoCodeModel!.isValid;
        return isValid ? ApplyButtonStatus.success : ApplyButtonStatus.invalid;
      }
    }

    return ApplyButtonStatus.idle;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (context) => CheckPromoCodeCubit(),
      child: BlocConsumer<CheckPromoCodeCubit, CheckPromoCodeState>(
        listener: (context, state) {
          if (state is CheckPromoCodeSuccess) {
            final provider = context.read<CartPriceProvider>();
            if (state.promoCodeModel != null && state.promoCodeModel!.isValid) {
              double discount = state.promoCodeModel!.calculateDiscount(
                provider.subTotal,
              );
              provider.setDiscount(dis: discount);
            } else {
              provider.setDiscount(dis: 0);
            }
            setState(() {
              _showResult = true;
            });
          }
        },
        builder: (context, state) {
          final status = _getStatus(state);
          Color backgroundColor;
          Widget content;

          switch (status) {
            case ApplyButtonStatus.loading:
              backgroundColor = theme.primaryColor;
              content = CupertinoActivityIndicator(
                color: theme.scaffoldBackgroundColor,
              );
              break;

            case ApplyButtonStatus.success:
              backgroundColor = Colors.green;
              content = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, color: Colors.white, size: 18.sp),
                  SizedBox(width: 5.w),
                  CustomText(
                    data: loc.applied,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              );
              break;

            case ApplyButtonStatus.invalid:
              backgroundColor = Colors.red;
              content = Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cancel, color: Colors.white, size: 18.sp),
                  SizedBox(width: 5.w),
                  CustomText(
                    data: loc.invalid,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ],
              );
              break;

            case ApplyButtonStatus.error:
              backgroundColor = Colors.redAccent;
              content = Icon(Icons.wifi_off, color: Colors.white, size: 18.sp);
              break;

            case ApplyButtonStatus.idle:
              backgroundColor = theme.primaryColor;
              content = CustomText(
                data: loc.apply,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                color: theme.scaffoldBackgroundColor,
              );
              break;
          }

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 45.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: GestureDetector(
              onTap: status == ApplyButtonStatus.loading
                  ? null
                  : () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (widget.textEditingController.text.isNotEmpty) {
                        context.read<CheckPromoCodeCubit>().isDiscounted(
                          code: widget.textEditingController.text,
                        );
                      }
                    },
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                transitionBuilder: (child, anim) =>
                    FadeTransition(opacity: anim, child: child),
                child: KeyedSubtree(
                  key: ValueKey<ApplyButtonStatus>(status),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: content,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
