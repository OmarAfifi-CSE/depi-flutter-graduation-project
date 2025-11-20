import 'package:batrina/models/category_model.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/promo_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:batrina/models/cart_model.dart';

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

  Future<Map<String, dynamic>> getProductsPaginated({
    required String category,
    int limit = 20, // عدد المنتجات اللي هنجيبها كل مرة
    DocumentSnapshot? lastDocument, // آخر دوكيومنت وصلنا له في المرة اللي فاتت
  }) async {
    // بنبني الـ Query الأساسي
    Query query = fireBaseFireStore
        .collection("products")
        .where("category", isEqualTo: category)
        .limit(limit);

    // لو دي مش أول مرة، بنقوله يبدأ من بعد آخر مكان وقفنا عنده
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    final querySnapshot = await query.get();

    // بنحوّل الداتا لموديلز
    final List<ProductModel> products = querySnapshot.docs.map((doc) {
      // مهم: مش هنجيب الـ variants هنا عشان السرعة
      return ProductModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();

    // بنرجع قايمة المنتجات وآخر دوكيومنت عشان نستخدمه في الطلب الجاي
    return {
      'products': products,
      'lastDoc': querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null,
    };
  }

  Future<ProductModel?> getProductWithVariants({
    required String productID,
  }) async {
    try {
      // 1. جيب الدوكيومنت الرئيسي للمنتج
      final docSnap = await fireBaseFireStore
          .collection("products")
          .doc(productID)
          .get();

      if (docSnap.exists) {
        // 2. حوّل الدوكيومنت لموديل المنتج
        ProductModel product = ProductModel.fromJson(docSnap.data()!);

        // 3. جيب الـ sub-collection بتاع الـ variants
        final variantsSnap = await fireBaseFireStore
            .collection("products")
            .doc(productID)
            .collection("variants")
            .get();

        // 4. حوّل الـ variants لموديلات وأضفهم للمنتج
        if (variantsSnap.docs.isNotEmpty) {
          product.variants.addAll(
            variantsSnap.docs
                .map((doc) => ProductVariant.fromJson(doc.data()))
                .toList(),
          );
        }
        return product;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final querySnapshot = await fireBaseFireStore
          .collection("categories")
          .get();
      if (querySnapshot.docs.isEmpty) {
        return [];
      }
      return querySnapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<List<ProductModel>> getFilteredProducts({
    required Set<String> categories,
    required double minPrice,
    required double maxPrice,
    //required String sortOrder,
    int? minRating,
  }) async {
    Query<Map<String, dynamic>> query = fireBaseFireStore.collection(
      'products',
    );

    if (categories.isNotEmpty) {
      query = query.where('category', whereIn: categories.toList());
    }

    query = query
        .where('price', isGreaterThanOrEqualTo: minPrice)
        .where('price', isLessThanOrEqualTo: maxPrice);

    if (minRating != null) {
      query = query.where('rating', isGreaterThanOrEqualTo: minRating);
    }

    // if (sortOrder == 'ascending') {
    //   query = query.orderBy('price', descending: false);
    // } else {
    //   query = query.orderBy('price', descending: true);
    // }

    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
  }

  Future<List<ProductModel>> getFilteredProductsPaginated({
    required Set<String> categories,
    required double minPrice,
    required double maxPrice,
    //required String sortOrder,
    int? minRating,
    int limit = 5,
    DocumentSnapshot? lastDocument,
  }) async {
    Query<Map<String, dynamic>> query = fireBaseFireStore.collection(
      'products',
    );

    if (categories.isNotEmpty) {
      query = query.where('category', whereIn: categories.toList());
    }

    query = query
        .where('price', isGreaterThanOrEqualTo: minPrice)
        .where('price', isLessThanOrEqualTo: maxPrice);

    if (minRating != null) {
      query = query.where('rating', isGreaterThanOrEqualTo: minRating);
    }

    // if (sortOrder == 'ascending') {
    //   query = query.orderBy('price', descending: false);
    // } else {
    //   query = query.orderBy('price', descending: true);
    // }
    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }
    query = query.orderBy('price');
    query = query.limit(limit);
    final snapshot = await query.get();

    if (snapshot.docs.isEmpty) {
      return [];
    }

    return snapshot.docs.map((e) => ProductModel.fromJson(e.data())).toList();
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

  Future<List<ProductModel>> getUserWishList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishList")
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }
    List<ProductModel> userWishList = querySnapshot.docs.map((e) {
      return ProductModel.fromJson(e.data());
    }).toList();
    return userWishList;
  }

  Future<List<AddressModel>> getAddresses() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userAddresses")
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }
    List<AddressModel> addresses = querySnapshot.docs.map((e) {
      return AddressModel.fromJson(e.data());
    }).toList();
    return addresses;
  }

  Future<void> addAddress({required AddressModel address}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        fireBaseFireStore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userAddresses")
            .doc();
    AddressModel addressWithId = address.copyWith(id: documentReference.id);
    await documentReference.set(addressWithId.toJson());
  }

  Future<void> removeAddress({required AddressModel address}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userAddresses")
        .doc(address.id)
        .delete();
  }

  Future<void> addMainAddressForUser({required AddressModel address}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'mainAddressId': address.id}, SetOptions(merge: true));
  }

  Future<void> removeMainAddressForUser({required AddressModel address}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({'mainAddressId': null}, SetOptions(merge: true));
  }

  Future<void> editUser({required UserModel userModel}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userModel.toJson(), SetOptions(merge: true));
  }

  Future<CartModel> addToCart({required CartModel cartModel}) async {
    //هنشوف الاول هل الكوانتيي نظبوطه للتاكيد
    //هنجيب الفارييانت بالضبط
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fireBaseFireStore
            .collection("products")
            .doc(cartModel.productId)
            .collection("variants")
            .doc(cartModel.variantId)
            .get();
    if (!documentSnapshot.exists) {
      throw Exception();
    }
    ProductVariant updatedVariant = ProductVariant.fromJson(
      documentSnapshot.data()!,
    );
    if (cartModel.quantity > updatedVariant.stock) {
      throw Exception("not_available");
    }
    DocumentReference<Map<String, dynamic>> documentReference =
        fireBaseFireStore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userCart")
            .doc();
    CartModel cartModelWithNewID = cartModel.copyWith(id: documentReference.id);
    await documentReference.set(cartModelWithNewID.toJson());
    //عملنا كده علشان لما اضيفو لوكال يبقي معايا الايدي الجديد
    return cartModelWithNewID;
  }

  Future<void> removeFromCart({required String cartId}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(cartId)
        .delete();
  }

  //هنجيب ايدي الفاريانت اللي حاططها في الكارت
  Future<List<CartModel>> getUserCartForProduct({
    required ProductModel productModel,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .where("productId", isEqualTo: productModel.id)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }
    List<CartModel> userCartForProduct = querySnapshot.docs
        .map((e) => CartModel.fromJson(e.data()))
        .toList();
    return userCartForProduct;
  }

  Future<List<CartModel>> getUserCart() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("users")
        .doc(userId)
        .collection("userCart")
        .orderBy("addedAt", descending: true)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    // جيب الـ cart
    List<CartModel> userCart = querySnapshot.docs
        .map((e) => CartModel.fromJson(e.data()))
        .toList();

    // جمع الـ products IDs
    Map<String, List<CartModel>> productVariants = {};
    for (var cart in userCart) {
      if (!productVariants.containsKey(cart.productId)) {
        productVariants[cart.productId] = [];
      }
      productVariants[cart.productId]!.add(cart);
    }

    // قائمة الـ items اللي هنحذفها
    List<String> itemsToRemove = [];

    // لكل product
    for (var product in productVariants.entries) {
      // جيب كل الـ variants للـ product ده مرة واحدة
      final variantsSnapshot = await fireBaseFireStore
          .collection("products")
          .doc(product.key)
          .collection("variants")
          .get();

      // خزن الـ variants في Map
      Map<String, ProductVariant> variantsMap = {};
      for (var doc in variantsSnapshot.docs) {
        variantsMap[doc.id] = ProductVariant.fromJson(doc.data());
      }

      // شيك على كل cart item
      for (var cart in product.value) {
        final variant = variantsMap[cart.variantId];

        //حتته النال علشان لو اصلا اتشالت م الداتابيز الفارينت ده
        if (variant == null || variant.stock == 0) {
          await fireBaseFireStore
              .collection("users")
              .doc(userId)
              .collection("userCart")
              .doc(cart.id)
              .delete();

          itemsToRemove.add(cart.id);
        } else if (variant.stock < cart.quantity) {
          await fireBaseFireStore
              .collection("users")
              .doc(userId)
              .collection("userCart")
              .doc(cart.id)
              .update({
                "quantity": variant.stock,
                "availableStock": variant.stock,
              });

          // حدث الـ local cart
          cart.quantity = variant.stock;
        } else if (cart.availableStock != variant.stock) {
          await fireBaseFireStore
              .collection("users")
              .doc(userId)
              .collection("userCart")
              .doc(cart.id)
              .update({"availableStock": variant.stock});
        }
        cart.availableStock = variant!.stock;
      }
    }

    // امسح الـ items المحذوفة من الـ list
    userCart.removeWhere((cart) => itemsToRemove.contains(cart.id));

    return userCart;
  }

  Future<PromoCodeModel?> isDiscounted({required String code}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("promos")
        .where("code", isEqualTo: code)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return null;
    }
    return PromoCodeModel.fromJson(querySnapshot.docs.first.data());
  }

  Future<List<ConversationModel>> getMessages() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("conversations")
        .where("participants", arrayContains: FireBaseFireStore.currentUser!.id)
        .orderBy('lastMessageTime', descending: true)
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }
    return querySnapshot.docs.map((e) {
      return ConversationModel.fromJson(e.data());
    }).toList();
  }
}
