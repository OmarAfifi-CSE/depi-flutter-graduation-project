import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/chat_page_models/conservesion_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit() : super(GetMessagesInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  Future getMessages() async {
    try {
      emit(GetMessagesLoading());
      List<ConversationModel> conversations = await fireBaseFireStore
          .getMessages();
      emit(GetMessagesSuccess(conversations: conversations));
    } catch (e) {
      emit(GetMessagesFailure(error: "error happened"));
    }
  }
}
