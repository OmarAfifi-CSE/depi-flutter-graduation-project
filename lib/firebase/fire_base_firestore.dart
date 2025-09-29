import 'package:batrina/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseFireStore {
  final fireBaseFireStore = FirebaseFirestore.instance;

  // This static variable holds the user data for the current app session.
  static UserModel? currentUser;

  // Fetches the full user profile from Firestore using their UID.
  Future<UserModel> getUserData(String uid) async {
    final docSnap = await fireBaseFireStore.collection("users").doc(uid).get();
    if (docSnap.exists) {
      return UserModel.fromJson(docSnap.data()!);
    } else {
      // This is a safeguard. In a real app, you might want to handle this more gracefully.
      throw Exception("User data not found in Firestore!");
    }
  }

  // Creates a user document in Firestore ONLY if one doesn't already exist.
  // This prevents overwriting data on repeated logins (e.g., with Google Sign-In).
  Future<void> addUser({required UserModel user}) async {
    final docRef = fireBaseFireStore.collection("users").doc(user.id);
    final docSnap = await docRef.get();

    if (!docSnap.exists) {
      await docRef.set(user.toJson());
    }
  }
}
