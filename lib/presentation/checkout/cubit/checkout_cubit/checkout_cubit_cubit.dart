
import 'dart:async';

import 'package:BTechApp_Final_Project/models/checkout_model.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:BTechApp_Final_Project/repository/checkout_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'checkout_cubit_state.dart';


class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutRepository checkOutRepository = CheckOutRepository();
  int CheckOutCount = 0;

  List<CheckOutModel> CheckOutList = [];
  final EmployeeRepository repository = EmployeeRepository();
  Timer? autoDeleteTimer;

  CheckOutCubit():super(CheckOutState.initial());

  void startAutoDeleteTimer() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final midnight = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

    final timeUntilMidnight = midnight.difference(now);

    autoDeleteTimer = Timer(timeUntilMidnight, () {
      deleteAllCheckOuts();
      startAutoDeleteTimer();
    });
  }

  void cancelAutoDeleteTimer() {
    autoDeleteTimer?.cancel();
  }

  void getAllSuccessfulCheckedOut() async {
    emit(CheckOutState.loading());

    try {
      final list = await CheckOutRepository().getAllSuccessfulCheckOut();

      if (list.isNotEmpty) {
        emit(CheckOutState.success(list));
      } else {
        emit( CheckOutState.empty());
      }
    } catch (error) {
      emit(CheckOutState.failure(error.toString()));
    }
  }

  void updateList(String value) async {
    emit( CheckOutState.loading());

    try {
      final list = await CheckOutRepository().getAllSuccessfulCheckOut();

      if (value.isEmpty) {
        emit(CheckOutState.success(list));
      } else {
        final filteredList = list.where((element) =>
        element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.nik.toLowerCase().contains(value.toLowerCase())).toList();

        if (filteredList.isNotEmpty) {
          emit(CheckOutState.success(filteredList));
        } else {
          emit( CheckOutState.empty());
        }
      }
    } catch (error) {
      emit(CheckOutState.failure(error.toString()));
    }
  }

  void deleteAllCheckOuts() async {
    emit( CheckOutState.loading());

    try {
      // await CheckOutRepository.deleteAllCheckOut();
      emit( CheckOutState.empty());
    } catch (error) {
      emit(CheckOutState.failure(error.toString()));
    }
  }
}
