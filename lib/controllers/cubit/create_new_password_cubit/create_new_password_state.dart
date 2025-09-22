part of 'create_new_password_cubit.dart';

@immutable
sealed class CreateNewPasswordState {}

final class CreateNewPasswordInitial extends CreateNewPasswordState {}

final class CreateNewPasswordLoading extends CreateNewPasswordState {}

final class CreateNewPasswordFailure extends CreateNewPasswordState {
  final String error;
  CreateNewPasswordFailure(this.error);
}

final class CreateNewPasswordSuccess extends CreateNewPasswordState {}
