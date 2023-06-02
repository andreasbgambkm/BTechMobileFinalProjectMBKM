import 'dart:async';
import 'package:BTechApp_Final_Project/models/checkout_model.dart';
import 'package:BTechApp_Final_Project/repository/checkout_repository.dart';
import 'package:BTechApp_Final_Project/repository/employee_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'checkout_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutRepository checkoutRepository = CheckOutRepository();
  int checkoutCount = 0;

  List<CheckOutModel> checkoutList = [];
  final EmployeeRepository repository = EmployeeRepository();
  Timer? autoDeleteTimer;

  CheckOutCubit() : super(CheckOutLoading());

  void startAutoDeleteTimer() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final midnight = DateTime(tomorrow.year, tomorrow.month, tomorrow.day);

    final timeUntilMidnight = midnight.difference(now);

    autoDeleteTimer = Timer(timeUntilMidnight, () {
      deleteAllcheckouts();
      startAutoDeleteTimer();
    });
  }

  void cancelAutoDeleteTimer() {
    autoDeleteTimer?.cancel();
  }

  void addCheckout(CheckOutModel checkout) {
    final List<CheckOutModel> updatedList = List.from(checkoutList);
    updatedList.add(checkout);
    emit(CheckOutSuccess(updatedList));
  }



  void getAllSuccessfulCheckedOut() async {
    emit(CheckOutLoading());

    try {
      final list = await checkoutRepository.getAllSuccessfulCheckOut();

      if (list.isNotEmpty) {
        emit(CheckOutSuccess(list));
      } else {
        emit(CheckOutEmpty());
      }

    } catch (error) {
      emit(CheckOutFailure(error.toString()));
    }
  }

  void updateList(String value) async {
    emit(CheckOutLoading());

    try {
      final list = await checkoutRepository.getAllSuccessfulCheckOut();

      if (value.isEmpty) {
        emit(CheckOutSuccess(list));
      } else {
        final filteredList = list.where((element) =>
        element.name.toLowerCase().contains(value.toLowerCase()) ||
            element.nik.toLowerCase().contains(value.toLowerCase())).toList();

        if (filteredList.isNotEmpty) {
          emit(CheckOutSuccess(filteredList));
        } else {
          emit(CheckOutEmpty());
        }
      }
    } catch (error) {
      emit(CheckOutFailure(error.toString()));
    }
  }

  void deleteAllcheckouts() async {
    emit(CheckOutLoading());

    try {
      await checkoutRepository.deleteAllCheckOut();
      emit(CheckOutEmpty());
    } catch (error) {
      emit(CheckOutFailure(error.toString()));
    }
  }

  void updateNote(int id, String updatedNote) async {
    emit(CheckOutLoading());

    try {
      await checkoutRepository.updateCheckOutNote(id, updatedNote);
      refresh();
    } catch (error) {
      emit(CheckOutFailure(error.toString()));
    }
  }


  void refresh() async {
    emit(CheckOutLoading());
    try {
      final list = await checkoutRepository.getAllSuccessfulCheckOut();
      emit(CheckOutSuccess(list));
    } catch (error) {
      emit(CheckOutFailure(error.toString()));
    }
  }
}
