import 'package:batrina/models/cart_model.dart';

class ProductNavigationData {
  final String productId;
  final CartModel? cartModel;

  ProductNavigationData({required this.productId, this.cartModel});
}
