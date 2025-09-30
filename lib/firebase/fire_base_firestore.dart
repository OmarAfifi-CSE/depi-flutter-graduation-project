import 'package:batrina/main.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<void> addProduct(ProductModel product) async {
    DocumentReference documentReference = await fireBaseFireStore
        .collection("products")
        .add(product.toJson());

    await documentReference.update({"id": documentReference.id});

    DocumentReference variantDocumentReference;

    for (var variant in product.variants) {
      variantDocumentReference = await documentReference
          .collection("variants")
          .add(variant.toJson());
      await variantDocumentReference.update({
        "id": variantDocumentReference.id,
      });
    }
  }

  Future<void> getProductVariants({required ProductModel productModel}) async {
    // جيب الـ variants لكل product
    final variantsSnapshot = await fireBaseFireStore
        .collection("products")
        .doc(productModel.id)
        .collection("variants")
        .get();

    List<ProductVariant> variants = variantsSnapshot.docs
        .map((doc) => ProductVariant.fromJson(doc.data()))
        .toList();
    productModel.variants.addAll(variants);
  }

  Future<List<ProductModel>> getCategoriesProduct(String category) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("products")
        .where("category", isEqualTo: category)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    List<ProductModel> categoryProduct = querySnapshot.docs.map((e) {
      return ProductModel.fromJson(e.data());
    }).toList();
    return categoryProduct;
  }

  Future<ProductModel?> getProduct({required String productID}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fireBaseFireStore.collection("product").doc(productID).get();
    if (documentSnapshot.exists) {
      return ProductModel.fromJson(documentSnapshot.data()!);
    }
    return null;
  }

  Future<void> addToWishList({required ProductModel productModel}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishList")
        .doc(productModel.id)
        .set(productModel.toJson(), SetOptions(merge: true));
  }

  Future<void> removeFromWishList({required ProductModel productModel}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishList")
        .doc(productModel.id)
        .delete();
  }

  Future<bool> checkIfItInFav({required ProductModel productModel}) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fireBaseFireStore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userWishList")
            .doc(productModel.id)
            .get();
    return documentSnapshot.exists;
  }

  Future<List<ReviewModel>> getReviews({
    required ProductModel productModel,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("products")
        .doc(productModel.id)
        .collection("productReviews")
        .orderBy("createdAt", descending: true)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }
    List<ReviewModel> reviews = querySnapshot.docs.map((e) {
      return ReviewModel.fromJson(e.data());
    }).toList();
    return reviews;
  }

  Future<void> addReview({
    required ReviewModel reviewModel,
    required ProductModel productModel,
  }) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await fireBaseFireStore
            .collection("products")
            .doc(productModel.id)
            .collection("productReviews")
            .add(reviewModel.toJson());

    await documentReference.update({"id": documentReference.id});

    final reviewsSnapshot = await fireBaseFireStore
        .collection("products")
        .doc(productModel.id)
        .collection("productReviews")
        .get();

    double totalRating = 0;
    int reviewCount = 0;

    for (var doc in reviewsSnapshot.docs) {
      final review = ReviewModel.fromJson(doc.data());
      totalRating += review.rating;
      reviewCount++;
    }

    double averageRating = reviewCount > 0 ? totalRating / reviewCount : 0.0;

    await fireBaseFireStore.collection("products").doc(productModel.id).update({
      'rating': averageRating,
      'reviewsCount': reviewCount,
    });
  }
}
