import 'package:batrina/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartPriceProvider extends ChangeNotifier {
  late double currentShipping;
  late double subTotal;
  late int count;
  late List<CartModel> currentCart;

  double get total => subTotal + currentShipping;

  void setPrice(List<CartModel> cart) {
    subTotal = cart.fold(
      0,
      (previousValue, element) => element.totalPrice + previousValue,
    );
    count = cart.length;
  }

  void init({required double shipping, required List<CartModel> cart}) {
    currentCart = cart;
    currentShipping = shipping;
    setPrice(cart);
  }

  void refresh() {
    setPrice(currentCart);
    notifyListeners();
  }
}
