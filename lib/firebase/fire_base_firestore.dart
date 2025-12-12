import 'package:batrina/models/category_model.dart';
import 'package:batrina/models/address_model.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/models/order_model.dart';
import 'package:batrina/models/product_model.dart';
import 'package:batrina/models/promo_model.dart';
import 'package:batrina/models/review_model.dart';
import 'package:batrina/models/user_model.dart';
import 'package:batrina/models/wish_list_model.dart';
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
    // 1. Determine Product Reference (New or Existing)
    DocumentReference<Map<String, dynamic>> productRef;

    if (product.id.isEmpty) {
      // Create new document reference
      productRef = fireBaseFireStore.collection("products").doc();
    } else {
      // Use existing document reference
      productRef = fireBaseFireStore.collection("products").doc(product.id);
    }

    // 2. Save Product Data (Ensuring the ID is set in the model)
    ProductModel productToSave = product.copyWith(id: productRef.id);

    await productRef.set(productToSave.toJson(), SetOptions(merge: true));

    // 3. Handle Variants
    // If this was an existing product, delete old variants first to prevent duplicates/stale data.
    if (product.id.isNotEmpty) {
      QuerySnapshot<Map<String, dynamic>> oldVariants = await productRef
          .collection("variants")
          .get();

      for (var doc in oldVariants.docs) {
        await doc.reference.delete();
      }
    }

    // 4. Add/Re-add Variants
    for (var variant in product.variants) {
      DocumentReference variantRef;
      // Check if variant ID is empty
      if (variant.id.isEmpty) {
        // If empty, auto-generate a new ID
        variantRef = productRef.collection("variants").doc();
      } else {
        // If exists, use the specific ID
        variantRef = productRef.collection("variants").doc(variant.id);
      }

      // Ensure the variant model has the correct ID (new or existing)
      ProductVariant variantToSave = variant.copyWith(id: variantRef.id);

      await variantRef.set(variantToSave.toJson(), SetOptions(merge: true));
    }
  }

  Future<void> deleteProduct(String pId) async {
    QuerySnapshot<Map<String, dynamic>> variants = await fireBaseFireStore
        .collection('products')
        .doc(pId)
        .collection("variants")
        .get();
    if (variants.docs.isNotEmpty) {
      for (QueryDocumentSnapshot queryDocumentSnapshot in variants.docs) {
        await queryDocumentSnapshot.reference.delete();
      }
    }
    QuerySnapshot<Map<String, dynamic>> reviews = await fireBaseFireStore
        .collection('products')
        .doc(pId)
        .collection("productReviews")
        .get();
    if (reviews.docs.isNotEmpty) {
      for (QueryDocumentSnapshot queryDocumentSnapshot in reviews.docs) {
        await queryDocumentSnapshot.reference.delete();
      }
    }
    await fireBaseFireStore.collection('products').doc(pId).delete();
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

  Stream<List<CategoryModel>> getCategoriesStream(bool isAdmin) {
    Query<Map<String, dynamic>> query = fireBaseFireStore.collection(
      "categories",
    );

    if (!isAdmin) {
      query = query.where("isActive", isEqualTo: true);
    }

    query = query
        .orderBy('rank', descending: false)
        .orderBy('createdAt', descending: true);

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        var data = doc.data();
        data['id'] = doc.id;
        return CategoryModel.fromJson(data);
      }).toList();
    });
  }

  Future<void> updateCategoriesOrder(List<CategoryModel> categories) async {
    WriteBatch batch = fireBaseFireStore.batch();

    for (var category in categories) {
      DocumentReference docRef = fireBaseFireStore
          .collection("categories")
          .doc(category.id);
      batch.update(docRef, {'rank': category.rank});
    }

    await batch.commit();
  }

  Future<void> addOrUpdateCategory({
    required CategoryModel category,
    String? oldName,
  }) async {
    if (category.id.isEmpty) {
      DocumentReference docRef = fireBaseFireStore
          .collection("categories")
          .doc();
      CategoryModel newCategory = category.copyWith(id: docRef.id);
      await docRef.set(newCategory.toJson(), SetOptions(merge: true));
    } else {
      await fireBaseFireStore
          .collection("categories")
          .doc(category.id)
          .set(category.toJson(), SetOptions(merge: true));

      if (oldName != null && oldName != category.name) {
        QuerySnapshot productsSnapshot = await fireBaseFireStore
            .collection("products")
            .where("category", isEqualTo: oldName)
            .get();

        if (productsSnapshot.docs.isNotEmpty) {
          await _updateProductsListInBatches(
            productsSnapshot.docs,
            category.name,
          );
        }
      }
    }
  }

  Future<void> _updateProductsListInBatches(
    List<QueryDocumentSnapshot> productDocs,
    String newCategoryName,
  ) async {
    const int batchSize = 500;
    for (int i = 0; i < productDocs.length; i += batchSize) {
      WriteBatch batch = fireBaseFireStore.batch();
      int end = (i + batchSize < productDocs.length)
          ? i + batchSize
          : productDocs.length;
      List<QueryDocumentSnapshot> chunk = productDocs.sublist(i, end);
      for (var doc in chunk) {
        batch.update(doc.reference, {'category': newCategoryName});
      }
      await batch.commit();
    }
  }

  Future<void> deleteCategory(String categoryId, String categoryName) async {
    List<DocumentReference> allReferencesToDelete = [];
    allReferencesToDelete.add(
      fireBaseFireStore.collection("categories").doc(categoryId),
    );
    QuerySnapshot productsSnapshot = await fireBaseFireStore
        .collection("products")
        .where("category", isEqualTo: categoryName)
        .get();
    for (var productDoc in productsSnapshot.docs) {
      allReferencesToDelete.add(productDoc.reference);
      QuerySnapshot variantsSnapshot = await productDoc.reference
          .collection('variants')
          .get();
      for (var variantDoc in variantsSnapshot.docs) {
        allReferencesToDelete.add(variantDoc.reference);
      }
    }
    await _deleteListInBatches(allReferencesToDelete);
  }

  Future<void> _deleteListInBatches(List<DocumentReference> refs) async {
    const int batchSize = 500;
    for (int i = 0; i < refs.length; i += batchSize) {
      WriteBatch batch = fireBaseFireStore.batch();
      int end = (i + batchSize < refs.length) ? i + batchSize : refs.length;
      List<DocumentReference> chunk = refs.sublist(i, end);
      for (var ref in chunk) {
        batch.delete(ref);
      }
      await batch.commit();
    }
  }

  Future<List<ProductModel>> getFilteredProducts({
    required Set<String> categories,
    required double minPrice,
    required double maxPrice,
    int? rating,
    String? sortOrder,
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
    if (rating != null) {
      query = query.where('rating', isGreaterThanOrEqualTo: rating);
    }

    if (sortOrder == 'Ascending') {
      query = query.orderBy('price', descending: false);
    } else if (sortOrder == 'Descending') {
      query = query.orderBy('price', descending: true);
    }

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

  Future<String> addToWishList({required WishlistModel wishListModel}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        await fireBaseFireStore
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("userWishList")
            .doc();
    await documentReference.set(wishListModel.toJson());
    return documentReference.id;
  }

  Future<void> updateWishList({required WishlistModel wishListModel}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishList")
        .doc(wishListModel.id)
        .set(wishListModel.toJson(), SetOptions(merge: true));
  }

  Future<void> removeFromWishList({
    required WishlistModel wishListModel,
  }) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userWishList")
        .doc(wishListModel.id)
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

  Future<void> updateCart({required CartModel cartModel}) async {
    await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("userCart")
        .doc(cartModel.id)
        .set(cartModel.toJson(), SetOptions(merge: true));
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

    // جمع الـ products IDs عشان تقلل عدد الـ Reads
    Map<String, List<CartModel>> productVariants = {};
    for (var cart in userCart) {
      if (!productVariants.containsKey(cart.productId)) {
        productVariants[cart.productId] = [];
      }
      productVariants[cart.productId]!.add(cart);
    }

    // قائمة الـ items اللي هنحذفها من الليستة المحلية في الآخر
    List<String> itemsToRemove = [];

    // لكل product (عشان نجيب الفاريانتس بتاعته مرة واحدة)
    for (var product in productVariants.entries) {
      final variantsSnapshot = await fireBaseFireStore
          .collection("products")
          .doc(product.key)
          .collection("variants")
          .get();

      // خزن الـ variants في Map لسهولة البحث
      Map<String, ProductVariant> variantsMap = {};
      for (var doc in variantsSnapshot.docs) {
        variantsMap[doc.id] = ProductVariant.fromJson(doc.data());
      }

      // شيك على كل cart item تبع المنتج ده
      for (var cart in product.value) {
        final variant = variantsMap[cart.variantId];

        // الحالة الأولى: المنتج اتحذف خالص أو الكمية بقت صفر
        if (variant == null || variant.stock == 0) {
          // احذفه من الفايربيز
          await fireBaseFireStore
              .collection("users")
              .doc(userId)
              .collection("userCart")
              .doc(cart.id)
              .delete();

          // ضيفه للقائمة عشان نحذفه من اللوكل ليست
          itemsToRemove.add(cart.id);

          // 🛑 مهم جداً: كمل اللفة ومتنزلش تحت عشان ميضربش Null Check
          continue;
        }

        // --- من هنا ونازل إحنا متأكدين إن variant موجود ومش null ---

        if (variant.stock < cart.quantity) {
          // لو الكمية المتاحة أقل من اللي اليوزر طالبه -> نزل الكمية للحد الأقصى المتاح
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
          // تحديث مجرد لمعلومية المخزون (مش بيأثر على الكمية اللي في السلة)
          await fireBaseFireStore
              .collection("users")
              .doc(userId)
              .collection("userCart")
              .doc(cart.id)
              .update({"availableStock": variant.stock});
        }

        // تحديث المخزون المتاح في الاوبجيكت المحلي
        cart.availableStock = variant.stock;
      }
    }

    // امسح الـ items المحذوفة من الـ list النهائية اللي راجعة للـ UI
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

  Future<List<WishlistModel>> getWishList() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await fireBaseFireStore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userWishList')
        .get();
    if (querySnapshot.docs.isEmpty) {
      return [];
    }
    return querySnapshot.docs.map((e) {
      return WishlistModel.fromJson(e.data()).copyWith(id: e.id);
    }).toList();
  }

  // -----------------------------------------------
  // Orders Functions
  // -----------------------------------------------
  Future<void> placeOrder({required OrderModel order}) async {
    WriteBatch batch = fireBaseFireStore.batch();
    DocumentReference orderRef = fireBaseFireStore.collection('orders').doc();
    batch.set(orderRef, order.toJson());
    var cartSnapshot = await fireBaseFireStore
        .collection("users")
        .doc(order.userId)
        .collection("userCart")
        .get();
    for (var doc in cartSnapshot.docs) {
      batch.delete(doc.reference);
    }
    for (var item in order.items) {
      DocumentReference variantRef = fireBaseFireStore
          .collection('products')
          .doc(item.productId)
          .collection('variants')
          .doc(item.variantId);
      batch.update(variantRef, {
        'stock': FieldValue.increment(-item.quantity),
      });
    }
    await batch.commit();
  }

  // 2. دالة جلب اوردرات اليوزر فقط (لصفحة My Orders)
  Stream<List<OrderModel>> getUserOrders() {
    return fireBaseFireStore
        .collection('orders')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  // 3. دالة جلب كل الاوردرات (للأدمن)
  Stream<List<OrderModel>> getAllOrdersForAdmin() {
    return fireBaseFireStore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => OrderModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  // 4. دالة تغيير حالة الاوردر (للأدمن)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await fireBaseFireStore.collection('orders').doc(orderId).update({
      'status': newStatus,
    });
  }
}
