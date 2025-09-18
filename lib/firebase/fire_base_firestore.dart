import 'package:batrina/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseFireStore {
  final fireBaseFireStore = FirebaseFirestore.instance;
  static UserModel? currentUser;

  Future<void> addUser({
    required UserModel user,
    required bool setCurrent,
  }) async {
    final docRef = fireBaseFireStore.collection("users").doc(user.id);
    final docSnap = await docRef.get();
    if (docSnap.exists) {
      if (setCurrent) {
        currentUser = UserModel.fromJson(docSnap.data()!);
      }
      return;
    }
    if (setCurrent) {
      currentUser = user;
    }
    await fireBaseFireStore
        .collection("users")
        .doc(user.id)
        .set(user.toJson(), SetOptions(merge: true));
  }
}
