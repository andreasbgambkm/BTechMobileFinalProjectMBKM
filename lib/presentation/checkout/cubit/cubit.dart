import 'package:bloc/bloc.dart';

import 'state.dart';

class CubitCubit extends Cubit<CubitState> {
  CubitCubit() : super(CubitState().init());
}
