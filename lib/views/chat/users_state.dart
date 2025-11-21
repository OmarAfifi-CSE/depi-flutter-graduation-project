import 'package:batrina/models/chat_page_models/conservesion_model.dart';

class UserStates {
  bool isPending;
  bool isAnotherUserRestricted;
  bool isAnotherUserPending;
  bool isRestricted;

  UserStates({
    required this.isPending,
    required this.isAnotherUserRestricted,
    required this.isAnotherUserPending,
    required this.isRestricted,
  });

  factory UserStates.fromConvModel(ConversationModel conversationModel) {
    bool isPending = false;
    bool isRestricted = false;
    bool isAnotherPending = false;
    bool isAnotherRestricted = false;

    if (conversationModel.me.conversationState == 'pending' ||
        conversationModel.me.conversationState == null) {
      isPending = true;
    } else if (conversationModel.me.conversationState == 'restricted') {
      isRestricted = true;
    }
    if (conversationModel.otherUser.conversationState == 'pending' ||
        conversationModel.otherUser.conversationState == null) {
      isAnotherPending = true;
    } else if (conversationModel.otherUser.conversationState == 'restricted') {
      isAnotherRestricted = true;
    }
    return UserStates(
      isPending: isPending,
      isAnotherUserRestricted: isAnotherRestricted,
      isAnotherUserPending: isAnotherPending,
      isRestricted: isRestricted,
    );
  }
}
