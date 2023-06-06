import 'package:bloc/bloc.dart';

import 'assistance_out_state.dart';

class Assistance_outCubit extends Cubit<Assistance_outState> {
  Assistance_outCubit() : super(Assistance_outState().init());
}
