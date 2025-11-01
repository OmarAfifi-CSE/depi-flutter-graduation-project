import 'package:batrina/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartPriceProvider extends ChangeNotifier {
  late double currentShipping;
  late double subTotal;
  late int count;
  double discount = 0;
  late List<CartModel> currentCart;

  double get total {
    if (subTotal + currentShipping - discount > 0) {
      return subTotal + currentShipping - discount;
    } else {
      return 0.0;
    }
  }

  double get totalNoDis => subTotal + currentShipping;

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

  void setDiscount({required double dis}) {
    discount = dis;
    notifyListeners();
  }
}
