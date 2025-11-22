import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:flutter/foundation.dart';

class LocalChatController extends ChangeNotifier {
  List<ConversationModel> conversationModels = [];
  void updateList(List<ConversationModel> newConversationModels) {
    conversationModels = newConversationModels;
    notifyListeners();
  }
}
