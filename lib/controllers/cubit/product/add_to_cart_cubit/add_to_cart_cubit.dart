import 'package:batrina/firebase/fire_base_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_to_cart_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(AddToCartInitial());
  Future<void> addToCart() async {}
}
