import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/promo_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'check_promo_code_state.dart';

class CheckPromoCodeCubit extends Cubit<CheckPromoCodeState> {
  CheckPromoCodeCubit() : super(CheckPromoCodeInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  Future<void> isDiscounted({required String code}) async {
    try {
      emit(CheckPromoCodeLoading());
      PromoCodeModel? promoCodeModel = await fireBaseFireStore.isDiscounted(
        code: code,
      );
      emit(CheckPromoCodeSuccess(promoCodeModel));
    } catch (e) {
      emit(CheckPromoCodeFailure("error happened"));
    }
  }
}
