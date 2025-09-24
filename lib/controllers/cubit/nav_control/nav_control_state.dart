part of 'nav_control_cubit.dart';

@immutable
sealed class NavControlState {
  final int index;

  NavControlState({required this.index});
}

final class NavControlInitial extends NavControlState {
  NavControlInitial() : super(index: 0);
}

final class NavControlValue extends NavControlState {
  NavControlValue(int index) : super(index: index);
}
