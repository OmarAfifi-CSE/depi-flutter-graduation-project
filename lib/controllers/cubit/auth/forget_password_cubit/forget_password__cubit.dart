import 'package:batrina/firebase/fire_base_auth.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'forget_password__state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());
  AppLocalizations? loc;
  FireBaseAuth fireBaseAuth = FireBaseAuth();

  Future<void> forgetPass({
    required String email,
    required String lang,
    required String themeModeName,
  }) async {
    try {
      emit(ForgetPasswordLoading());
      await fireBaseAuth.sendEmailResetPass(
        email: email,
        lang: lang,
        themeModeName: themeModeName,
      );
      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgetPasswordFailure(_handleFirebaseForgetPassError(e)));
    } catch (e) {
      emit(ForgetPasswordFailure(loc!.errorHappened));
    }
  }

  String _handleFirebaseForgetPassError(FirebaseAuthException e) {
    switch (e.code) {
      // الشبكة
      case 'network-request-failed':
        return loc!.networkRequestFailedDescription;

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
