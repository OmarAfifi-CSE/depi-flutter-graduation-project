import 'package:batrina/l10n/app_localizations.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'verify_create_new_password_state.dart';

class VerifyCreateNewPasswordCubit extends Cubit<VerifyCreateNewPasswordState> {
  VerifyCreateNewPasswordCubit() : super(VerifyCreateNewPasswordInitial());

  AppLocalizations? loc;

  Future<void> verifyCode({required String oobCode}) async {
    emit(VerifyCreateNewPasswordLoading());
    try {
      await FirebaseAuth.instance.verifyPasswordResetCode(oobCode);
      emit(VerifyCreateNewPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        emit(VerifyCreateNewPasswordFailure(loc!.invalid_or_expired_link));
      } else {
        emit(VerifyCreateNewPasswordFailure(loc!.unexpected_error));
      }
    }
  }
}
