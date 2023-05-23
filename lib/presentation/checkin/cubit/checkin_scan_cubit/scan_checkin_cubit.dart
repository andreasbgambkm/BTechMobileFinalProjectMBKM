import 'package:bloc/bloc.dart';

import 'scan_checkin_state.dart';

class Scan_checkinCubit extends Cubit<Scan_checkinState> {
  Scan_checkinCubit() : super(Scan_checkinState().init());
}
