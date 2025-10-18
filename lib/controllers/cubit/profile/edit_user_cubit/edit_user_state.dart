part of 'edit_user_cubit.dart';

@immutable
sealed class EditUserState {}

final class EditUserInitial extends EditUserState {}

final class EditUserLoading extends EditUserState {}

final class EditUserSuccess extends EditUserState {}

final class EditUserFailure extends EditUserState {
  final String error;

  EditUserFailure({required this.error});
}
