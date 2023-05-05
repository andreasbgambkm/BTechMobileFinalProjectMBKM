import 'package:BTechApp_Final_Project/presentation/home/cubit/state.dart';
import 'package:bloc/bloc.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState().init());
}
