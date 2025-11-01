import 'package:flutter/material.dart';

class OpenDetailsProvider extends ChangeNotifier {
  bool isOpen = false;

  void openDetails() {
    isOpen = true;
    notifyListeners();
  }

  void closeDetails() {
    isOpen = false;
    notifyListeners();
  }

  void toggle() {
    isOpen = !isOpen;
    notifyListeners();
  }
}
