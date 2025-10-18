part of 'verify_create_new_password_cubit.dart';

@immutable
sealed class VerifyCreateNewPasswordState {}

final class VerifyCreateNewPasswordInitial
    extends VerifyCreateNewPasswordState {}

final class VerifyCreateNewPasswordLoading
    extends VerifyCreateNewPasswordState {}

final class VerifyCreateNewPasswordSuccess
    extends VerifyCreateNewPasswordState {}

final class VerifyCreateNewPasswordFailure
    extends VerifyCreateNewPasswordState {
  final String error;
  VerifyCreateNewPasswordFailure(this.error);
}
