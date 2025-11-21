import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:batrina/views/chat/users_state.dart';
import 'package:flutter/foundation.dart';

class LocalChatController extends ChangeNotifier {
  List<ConversationModel> conversationModels = [];
  void updateList(List<ConversationModel> newConversationModels) {
    conversationModels = newConversationModels;
    notifyListeners();
  }

  UserStates? getUserStates({required String chatId}) {
    try {
      final ConversationModel conversationModel = conversationModels
          .where((element) => element.id == chatId)
          .first;
      return UserStates.fromConvModel(conversationModel);
    } catch (e) {
      return null;
    }
  }
}
