part of 'add_button_control_cubit.dart';

@immutable
sealed class AddButtonControlState {}

final class AddButtonControlClose extends AddButtonControlState {}

final class AddButtonControlOpen extends AddButtonControlState {}
