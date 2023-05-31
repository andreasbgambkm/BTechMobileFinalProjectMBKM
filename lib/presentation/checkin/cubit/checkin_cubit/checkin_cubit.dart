import 'dart:async';
import 'package:BTechApp_Final_Project/models/checkin_model.dart';
import 'package:BTechApp_Final_Project/repository/checkin_repository.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'checkin_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInRepository checkInRepository = CheckInRepository();
  int checkInCount = 0;

  List<CheckInModel> checkInList = [];
  final EmployeeRepository repository = EmployeeRepository();
  Timer? autoDeleteTimer;

  CheckInCubit() : super(CheckInLoading());

  void startAutoDeleteTimer() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final midnight = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

    final timeUntilMidnight = midnight.difference(now);

    autoDeleteTimer = Timer(timeUntilMidnight, () {
      deleteAllCheckIns();
      startAutoDeleteTimer();
    });
  }

  void cancelAutoDeleteTimer() {
    autoDeleteTimer?.cancel();
  }

  void addCheckIn(CheckInModel checkIn) {
    final List<CheckInModel> updatedList = List.from(checkInList);
    updatedList.add(checkIn);
    emit(CheckInSuccess(updatedList));
  }

  void getAllSuccessfulCheckedIn() async {
    emit(CheckInLoading());

    try {
      final list = await checkInRepository.getAllSuccessfulCheckIns();

      if (list.isNotEmpty) {
        emit(CheckInSuccess(list));
      } else {
        emit(CheckInEmpty());
      }

    } catch (error) {
      emit(CheckInFailure(error.toString()));
    }
  }

  void updateList(String value) async {
    emit(CheckInLoading());

    try {
      final list = await checkInRepository.getAllSuccessfulCheckIns();

      if (value.isEmpty) {
        emit(CheckInSuccess(list));
      } else {
        final filteredList = list.where((element) =>
        element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.nik.toLowerCase().contains(value.toLowerCase())).toList();

        if (filteredList.isNotEmpty) {
          emit(CheckInSuccess(filteredList));
        } else {
          emit(CheckInEmpty());
        }
      }
    } catch (error) {
      emit(CheckInFailure(error.toString()));
    }
  }

  void deleteAllCheckIns() async {
    emit(CheckInLoading());

    try {
      await checkInRepository.deleteAllCheckIn();
      emit(CheckInEmpty());
    } catch (error) {
      emit(CheckInFailure(error.toString()));
    }
  }

  void refresh() async {
    emit(CheckInLoading());
    try {
      final list = await checkInRepository.getAllSuccessfulCheckIns();
      emit(CheckInSuccess(list));
    } catch (error) {
      emit(CheckInFailure(error.toString()));
    }
  }
}
