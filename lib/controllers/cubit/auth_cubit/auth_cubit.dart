import 'package:batrina/firebase/fire_base_auth.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  FireBaseAuth fireBaseAuth = FireBaseAuth();
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  static const String googleSignInKeyOperation = "signInWithGoogle";
  static const String signInKeyOperation = "signIn";
  static const String signUpKeyOperation = "signUp";

  String? _currentOperation;
  AppLocalizations? loc;

  Future<void> signInWithGoogle() async {
    _currentOperation = googleSignInKeyOperation;
    try {
      emit(AuthGoogleLoading());
      UserCredential userCredential = await fireBaseAuth.signInWithGoogle();
      if (_currentOperation == googleSignInKeyOperation) {
        UserModel currentUser = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        );
        await fireBaseFireStore.addUser(setCurrent: true, user: currentUser);
        emit(AuthGoogleSuccess());
      }
    } on GoogleSignInException catch (e) {
      if (_currentOperation == googleSignInKeyOperation) {
        emit(AuthGoogleFailure(_handleGoogleSignInError(e)));
      }
    } on FirebaseAuthException catch (e) {
      if (_currentOperation == googleSignInKeyOperation) {
        emit(AuthGoogleFailure(_handleFirebaseAuthError(e)));
      }
    } catch (e) {
      if (_currentOperation == googleSignInKeyOperation) {
        emit(AuthGoogleFailure("Error happened"));
      }
    }
  }

  Future<void> signIn({required String email, required String pass}) async {
    _currentOperation = signInKeyOperation;

    try {
      emit(AuthSignInLoading());
      UserCredential userCredential = await fireBaseAuth.signIn(
        email: email,
        pass: pass,
      );
      if (_currentOperation == signInKeyOperation) {
        UserModel currentUser = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user?.displayName ?? "",
          email: userCredential.user!.email!,
        );
        await fireBaseFireStore.addUser(user: currentUser, setCurrent: true);
        emit(AuthSignInSuccess());
        print(FireBaseFireStore.currentUser!.name);
      }
    } on FirebaseAuthException catch (e) {
      if (_currentOperation == signInKeyOperation) {
        emit(AuthSignInFailure(_handleFirebaseAuthError(e)));
      }
    } catch (e) {
      if (_currentOperation == signInKeyOperation) {
        emit(AuthSignInFailure("Error happened"));
      }
    }
  }

  Future<void> signUp({
    required String email,
    required String pass,
    required String name,
  }) async {
    _currentOperation = signUpKeyOperation;
    try {
      emit(AuthSignUpLoading());
      UserModel currentUser = await fireBaseAuth.signUp(
        name: name,
        email: email,
        pass: pass,
      );
      if (_currentOperation == signUpKeyOperation) {
        await fireBaseFireStore.addUser(setCurrent: false, user: currentUser);
        emit(AuthSignUpSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (_currentOperation == signUpKeyOperation) {
        emit(AuthSignUpFailure(_handleFirebaseAuthError(e)));
      }
    } catch (e) {
      if (_currentOperation == signUpKeyOperation) {
        emit(AuthSignUpFailure("Error happened"));
      }
    }
  }

  void resetOperation() {
    _currentOperation = null;
  }

  String _handleGoogleSignInError(GoogleSignInException e) {
    final error = e.toString();

    if (error.contains('canceled')) {
      return loc!.googleSignInCanceledDescription;
    } else if (error.contains('network_error')) {
      return loc!.googleNetworkErrorDescription;
    } else if (error.contains('failed')) {
      return loc!.googleSignInFailedDescription;
    } else if (error.contains('clientConfigurationError')) {
      return loc!.googleConfigErrorDescription;
    } else {
      return loc!.googleUnexpectedErrorDescription;
    }
  }

  String _handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      // تسجيل مستخدم جديد
      case 'email-already-in-use':
        return loc!.emailAlreadyInUseDescription;
      case 'invalid-email':
        return loc!.invalidEmailDescription;
      case 'operation-not-allowed':
        return loc!.operationNotAllowedDescription;
      case 'weak-password':
        return loc!.weakPasswordDescription;

      // تسجيل دخول
      case 'user-disabled':
        return loc!.userDisabledDescription;
      case 'user-not-found':
        return loc!.userNotFoundDescription;
      case 'wrong-password':
        return loc!.wrongPasswordDescription;
      case 'invalid-credential':
        return loc!.invalidCredentialDescription;

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
