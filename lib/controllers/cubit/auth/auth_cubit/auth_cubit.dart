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
        // 1. Create a model with default data in case this is a new user
        UserModel userToSave = UserModel(
          id: userCredential.user!.uid,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
          picture: userCredential.user!.photoURL,
          role: 'user',
        );

        // 2. This will create the user in Firestore ONLY if they don't already exist.
        await fireBaseFireStore.addUser(user: userToSave);

        // 3. Now, fetch the definitive data from Firestore. This gets the correct role
        //    if the user is an existing admin.
        UserModel currentUser = await fireBaseFireStore.getUserData(
          userCredential.user!.uid,
        );

        // 4. Set the fetched user as the current user in your app
        FireBaseFireStore.currentUser = currentUser;

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
        emit(AuthGoogleFailure(loc!.errorHappened));
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
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          if (_currentOperation == signInKeyOperation) {
            // 1. Instead of creating a new UserModel, fetch the existing one from Firestore.
            UserModel currentUser = await fireBaseFireStore.getUserData(
              userCredential.user!.uid,
            );

            // 2. Now you have the full user data, including the correct role.
            //    Set it as the current user and cache it.
            FireBaseFireStore.currentUser = currentUser;

            emit(AuthSignInSuccess());
          }
        } else {
          await fireBaseAuth.signOut();
          emit(AuthSignInFailure(loc!.pleaseVerifyYourEmail));
        }
      }
    } on FirebaseAuthException catch (e) {
      if (_currentOperation == signInKeyOperation) {
        emit(AuthSignInFailure(_handleFirebaseAuthError(e)));
      }
    } catch (e) {
      if (_currentOperation == signInKeyOperation) {
        emit(AuthSignInFailure(loc!.errorHappened));
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
      // 1. Your signUp method in FireBaseAuth now creates a UserModel with role: 'user'
      UserModel currentUser = await fireBaseAuth.signUp(
        name: name,
        email: email,
        pass: pass,
      );

      User? firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        await firebaseUser.sendEmailVerification();
      }
      // Sign the user out immediately
      await fireBaseAuth.signOut();

      if (_currentOperation == signUpKeyOperation) {
        // 2. This now saves the new user with their default role to Firestore.
        await fireBaseFireStore.addUser(user: currentUser);
        emit(AuthSignUpSuccess());
      }
    } on FirebaseAuthException catch (e) {
      if (_currentOperation == signUpKeyOperation) {
        emit(AuthSignUpFailure(_handleFirebaseAuthError(e)));
      }
    } catch (e) {
      if (_currentOperation == signUpKeyOperation) {
        emit(AuthSignUpFailure(loc!.errorHappened));
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
      // Sign up errors
      case 'email-already-in-use':
        return loc!.emailAlreadyInUseDescription;
      case 'invalid-email':
        return loc!.invalidEmailDescription;
      case 'operation-not-allowed':
        return loc!.operationNotAllowedDescription;
      case 'weak-password':
        return loc!.weakPasswordDescription;
      // Sign in errors
      case 'user-disabled':
        return loc!.userDisabledDescription;
      case 'user-not-found':
        return loc!.userNotFoundDescription;
      case 'wrong-password':
        return loc!.wrongPasswordDescription;
      case 'invalid-credential':
        return loc!.invalidCredentialDescription;
      // Network errors
      case 'network-request-failed':
        return loc!.networkRequestFailedDescription;
      // Generic errors
      case 'invalid-verification-code':
        return loc!.invalidVerificationCodeDescription;
      case 'invalid-verification-id':
        return loc!.invalidVerificationIdDescription;
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
