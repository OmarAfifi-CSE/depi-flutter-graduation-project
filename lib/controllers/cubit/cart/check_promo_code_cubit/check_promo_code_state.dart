part of 'check_promo_code_cubit.dart';

@immutable
sealed class CheckPromoCodeState {}

final class CheckPromoCodeInitial extends CheckPromoCodeState {}

final class CheckPromoCodeSuccess extends CheckPromoCodeState {
  final PromoCodeModel? promoCodeModel;

  CheckPromoCodeSuccess(this.promoCodeModel);
}

final class CheckPromoCodeLoading extends CheckPromoCodeState {}

final class CheckPromoCodeFailure extends CheckPromoCodeState {
  final String error;
  CheckPromoCodeFailure(this.error);
}
