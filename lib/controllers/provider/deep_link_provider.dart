import 'package:flutter/material.dart';

class DeepLinkProvider extends ChangeNotifier {
  String? _pendingLink;

  String? get pendingLink => _pendingLink;

  void setDeepLink(String link) {
    _pendingLink = link;
    notifyListeners();
  }

  String? consumeDeepLink() {
    if (_pendingLink == null) return null;

    final String linkToReturn = _pendingLink!;
    _pendingLink = null;

    return linkToReturn;
  }
}
