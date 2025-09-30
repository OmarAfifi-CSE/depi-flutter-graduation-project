import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_button_control_state.dart';

class AddButtonControlCubit extends Cubit<AddButtonControlState> {
  AddButtonControlCubit() : super(AddButtonControlClose());
  void makeItClose() {
    emit(AddButtonControlClose());
  }

  void makeItOpen() {
    emit(AddButtonControlOpen());
  }
}
