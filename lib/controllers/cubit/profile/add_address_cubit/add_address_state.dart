part of 'add_address_cubit.dart';

@immutable
sealed class AddAddressState {}

final class AddAddressInitial extends AddAddressState {}

final class AddAddressLoading extends AddAddressState {}

final class AddAddressFailure extends AddAddressState {
  final String error;

  AddAddressFailure({required this.error});
}

final class AddAddressSuccess extends AddAddressState {}
