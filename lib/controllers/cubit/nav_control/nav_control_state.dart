part of 'nav_control_cubit.dart';

@immutable
sealed class NavControlState {
  final int index;

  const NavControlState({required this.index});
}

final class NavControlInitial extends NavControlState {
  const NavControlInitial() : super(index: 0);
}

final class NavControlValue extends NavControlState {
  const NavControlValue(int index) : super(index: index);
}
