import 'package:bloc/bloc.dart';

import 'checkout_scan_state.dart';

class Checkout_scanCubit extends Cubit<Checkout_scanState> {
  Checkout_scanCubit() : super(Checkout_scanState().init());
}
