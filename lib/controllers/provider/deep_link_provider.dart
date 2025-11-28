import 'package:flutter/material.dart';

class DeepLinkProvider extends ChangeNotifier {
  String? _pendingLink;

  String? get pendingLink => _pendingLink;

  void setDeepLink(String link) {
    _pendingLink = link;
    print("🔗 Deep Link Saved in Safe Box: $_pendingLink");
    notifyListeners();
  }

  String? consumeDeepLink() {
    if (_pendingLink == null) return null;

    final String linkToReturn = _pendingLink!;
    _pendingLink = null;

    print("🚀 Deep Link Consumed: $linkToReturn");
    return linkToReturn;
  }
}
