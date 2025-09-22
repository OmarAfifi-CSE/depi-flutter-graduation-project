import 'package:batrina/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuth {
  final fireAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn.instance;

  Future<UserCredential> signIn({
    required String email,
    required String pass,
  }) async {
    return await fireAuth.signInWithEmailAndPassword(
      email: email,
      password: pass,
    );
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String pass,
  }) async {
    UserCredential userCredential = await fireAuth
        .createUserWithEmailAndPassword(email: email, password: pass);
    return UserModel(id: userCredential.user!.uid, name: name, email: email);
  }

  Future<UserCredential> signInWithGoogle() async {
    print("here ");

    await googleSignIn.initialize(
      serverClientId:
          "558409290947-852ohvhnnsnthuroj6armveab2mdoci1.apps.googleusercontent.com",
    );
    GoogleSignInAccount googleSignInAccount = await googleSignIn.authenticate();
    GoogleSignInAuthentication googleSignInAuthentication =
        googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
    );

    UserCredential userCredential = await fireAuth.signInWithCredential(
      authCredential,
    );
    return userCredential;
  }

  Future<void> signOut() async {
    try {
      await fireAuth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      debugPrint("sign out error");
    }
  }

  Future<void> sendEmailResetPass({
    required String email,
    required String lang,
    required String themeModeName,
  }) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
      actionCodeSettings: ActionCodeSettings(
        url:
            "https://batrina-76502.web.app/action#theme=$themeModeName&lang=$lang",
        handleCodeInApp: true,
        androidPackageName: "com.oamao.batrina.batrina",
        androidInstallApp: true,
        androidMinimumVersion: "1",
        iOSBundleId: "com.oamao.batrina.batrina",
      ),
    );
  }

  Future<void> createNewPassword({
    required String code,
    required String newPassword,
  }) async {
    await fireAuth.confirmPasswordReset(code: code, newPassword: newPassword);
  }
}
