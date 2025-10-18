import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'nav_control_state.dart';

class NavControlCubit extends Cubit<NavControlState> {
  NavControlCubit() : super(const NavControlInitial());

  void setIndex(int index) {
    emit(NavControlValue(index));
  }
}
