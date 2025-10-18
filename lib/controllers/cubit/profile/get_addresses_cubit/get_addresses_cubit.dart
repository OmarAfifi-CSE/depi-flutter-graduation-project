import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:batrina/models/address_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_addresses_state.dart';

class GetAddressesCubit extends Cubit<GetAddressesState> {
  FireBaseFireStore fireBaseFireStore = FireBaseFireStore();
  GetAddressesCubit() : super(GetAddressesInitial());

  Future<void> getAddresses() async {
    emit(GetAddressesLoading());
    try {
      List<AddressModel> addresses = await fireBaseFireStore.getAddresses();
      emit(GetAddressesSuccess(addresses: addresses));
    } catch (e) {
      emit(GetAddressesFailure(error: "error happened"));
    }
  }

  void removeFromLocal({required AddressModel address}) {
    if (state is GetAddressesSuccess) {
      List<AddressModel> addresses = List.from(
        (state as GetAddressesSuccess).addresses,
      )..removeWhere((element) => element.id == address.id);
      emit(GetAddressesSuccess(addresses: addresses));
    }
  }
}
