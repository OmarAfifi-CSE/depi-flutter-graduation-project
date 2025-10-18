part of 'get_addresses_cubit.dart';

@immutable
sealed class GetAddressesState {}

final class GetAddressesInitial extends GetAddressesState {}

final class GetAddressesFailure extends GetAddressesState {
  final String error;

  GetAddressesFailure({required this.error});
}

final class GetAddressesSuccess extends GetAddressesState {
  final List<AddressModel> addresses;

  GetAddressesSuccess({required this.addresses});
}

final class GetAddressesLoading extends GetAddressesState {}
