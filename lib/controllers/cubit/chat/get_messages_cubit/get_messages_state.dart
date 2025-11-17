part of 'get_messages_cubit.dart';

@immutable
sealed class GetMessagesState {}

final class GetMessagesInitial extends GetMessagesState {}

final class GetMessagesLoading extends GetMessagesState {}

final class GetMessagesSuccess extends GetMessagesState {
  final List<ConversationModel> conversations;

  GetMessagesSuccess({required this.conversations});
}

final class GetMessagesFailure extends GetMessagesState {
  final String error;

  GetMessagesFailure({required this.error});
}
