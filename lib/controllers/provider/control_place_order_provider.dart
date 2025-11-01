import 'package:batrina/models/address_model.dart';
import 'package:flutter/cupertino.dart';

class ControlPlaceOrderProvider extends ChangeNotifier {
  AddressModel? currentAddress;

  void setMainAddress(AddressModel? addressModel) {
    currentAddress = addressModel;
    notifyListeners();
  }
}
