import 'package:BTechApp_Final_Project/core/app_expor.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(greeting: '', formattedDate: ''));

  void updateGreeting(DateTime now) {
    int hour = now.hour;
    String greeting;

    if (hour >= 0 && hour < 12) {
      greeting = 'Selamat Pagi';
    } else if (hour >= 12 && hour < 16) {
      greeting = 'Selamat Siang';
    } else if (hour >= 16 && hour < 19) {
      greeting = 'Selamat Sore';
    } else {
      greeting = 'Selamat Malam';
    }

    emit(state.copyWith(greeting: greeting));
  }

  void updateFormattedDate(String formattedDate) {
    emit(state.copyWith(formattedDate: formattedDate));
  }

}