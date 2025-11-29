import 'package:flutter_bloc/flutter_bloc.dart';

class AdminModeCubit extends Cubit<bool> {
  AdminModeCubit() : super(false);

  void setInitialMode(bool isRealAdmin) {
    emit(isRealAdmin);
  }

  void toggleMode() {
    emit(!state);
  }
}