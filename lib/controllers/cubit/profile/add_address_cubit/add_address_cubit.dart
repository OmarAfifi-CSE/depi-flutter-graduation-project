import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/l10n/app_localizations.dart';
import 'package:batrina/models/address_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'add_address_state.dart';

class AddAddressCubit extends Cubit<AddAddressState> {
  AddAddressCubit() : super(AddAddressInitial());
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();

  AppLocalizations? loc;

  Future<void> addAddress({required AddressModel address}) async {
    emit(AddAddressLoading());

    try {
      await fireBaseFireStore.addAddress(address: address);
      emit(AddAddressSuccess());
    } catch (e) {
      emit(
        AddAddressFailure(error: loc!.errorHappened),
      );
    }
  }
}
