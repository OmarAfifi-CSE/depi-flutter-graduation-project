import 'package:batrina/controllers/provider/profile_provider.dart';
import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit() : super(EditUserInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  Future<void> editUser({
    required BuildContext context,
    required UserModel user,
    required ProfileProvider profileProvider,
  }) async {
    try {
      emit(EditUserLoading());
      await fireBaseFireStore.editUser(userModel: user);
      FireBaseFireStore.currentUser = user;
      profileProvider.reset(
        name: profileProvider.currentName,
        image: profileProvider.currentImage,
      );
      FocusScope.of(context).unfocus();
      emit(EditUserSuccess());
    } catch (e) {
      emit(EditUserFailure(error: "error happened"));
    }
  }
}
