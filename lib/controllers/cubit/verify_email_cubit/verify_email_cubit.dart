import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:batrina/l10n/app_localizations.dart'; // Your localization file

part 'verify_email_state.dart';

class VerifyEmailCubit extends Cubit<VerifyEmailState> {
  VerifyEmailCubit() : super(VerifyEmailInitial());
  AppLocalizations? loc;

  Future<void> verifyEmail({required String oobCode}) async {
    emit(VerifyEmailLoading());
    try {
      await FirebaseAuth.instance.applyActionCode(oobCode);
      emit(VerifyEmailSuccess());
    } on FirebaseAuthException catch (e) {
      emit(VerifyEmailFailure(_handleFirebaseError(e)));
    } catch (e) {
      emit(VerifyEmailFailure(loc!.defaultAuthErrorDescription));
    }
  }

  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'expired-action-code':
        return loc!.expiredActionCodeDescription;
      case 'invalid-action-code':
        return loc!.invalidActionCodeDescription;
      case 'user-disabled':
        return loc!.userDisabledDescription;
      case 'user-not-found':
        return loc!.userNotFoundDescription;
      default:
        return loc!.defaultAuthErrorDescription;
    }
  }
}