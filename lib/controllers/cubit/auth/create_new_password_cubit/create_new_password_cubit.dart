import 'package:batrina/firebase/fire_base_auth.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_new_password_state.dart';

class CreateNewPasswordCubit extends Cubit<CreateNewPasswordState> {
  CreateNewPasswordCubit() : super(CreateNewPasswordInitial());
  FireBaseAuth fireBaseAuth = FireBaseAuth();
  AppLocalizations? loc;

  Future<void> createNewPassword({
    required String code,
    required String newPassword,
  }) async {
    try {
      emit(CreateNewPasswordLoading());
      await fireBaseAuth.createNewPassword(
        code: code,
        newPassword: newPassword,
      );
      emit(CreateNewPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(CreateNewPasswordFailure(_handleFirebaseCreateNewPasswordError(e)));
    } catch (e) {
      emit(CreateNewPasswordFailure(loc!.error_happened));
    }
  }

  String _handleFirebaseCreateNewPasswordError(FirebaseAuthException e) {
    switch (e.code) {
      // الشبكة
      case 'network-request-failed':
        return loc!.networkRequestFailedDescription;

      // التحقق
      case 'invalid-verification-code':
        return loc!.invalidVerificationCodeDescription;
      case 'invalid-verification-id':
        return loc!.invalidVerificationIdDescription;

      // مواقف عامة
      case 'too-many-requests':
        return loc!.tooManyRequestsDescription;
      case 'internal-error':
        return loc!.internalErrorDescription;
      case 'account-exists-with-different-credential':
        return loc!.accountExistsWithDifferentCredentialDescription;
      case 'credential-already-in-use':
        return loc!.credentialAlreadyInUseDescription;

      default:
        return loc!.defaultAuthErrorDescription;
    }
  }
}
