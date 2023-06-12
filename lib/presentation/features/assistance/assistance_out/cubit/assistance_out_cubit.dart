import 'package:BTechApp_Final_Project/data/models/assistance_out_model.dart';
import 'package:BTechApp_Final_Project/data/repositories/assistance_out_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assistance_out_state.dart';

class AssistanceOutCubit extends Cubit<AssistanceOutState> {
   AssistanceOutRepository assistanceOutRepository = AssistanceOutRepository();

  AssistanceOutCubit() : super(AssistanceOutInitial());

  Future<void> getAllAssistanceOut() async {
    try {
      emit(AssistanceOutLoading());
      final assistanceOutList = await assistanceOutRepository.getAllSuccessfulAssistedOut();
      emit(AssistanceOutSuccess(assistanceOutList, 0)); // Initialize selected counter to 0
    } catch (e) {
      emit(AssistanceOutError('Failed to get assistance out: $e'));
    }
  }

  Future<void> addAssistanceOut(AssistanceOutModel assistanceOut) async {
    try {
      await assistanceOutRepository.insertAssistanceOut(assistanceOut);
      emit(AssistanceOutSuccess([...(state as AssistanceOutSuccess).assistanceOutList, assistanceOut], (state as AssistanceOutSuccess).selectedCounter + 1));
    } catch (e) {
      emit(AssistanceOutError('Failed to add assistance out: $e'));
    }
  }

  void toggleSelectAllAssistanceOut(bool isSelectedAll) {
    if (isSelectedAll) {
      final assistanceOutList = (state as AssistanceOutSuccess).assistanceOutList;
      emit(AssistanceOutSuccess(assistanceOutList, assistanceOutList.length));
    } else {
      emit(AssistanceOutSuccess([], 0));
    }
  }

  void toggleSelectAssistanceOut(AssistanceOutModel assistanceOut, bool isSelected) {
    final assistanceOutList = (state as AssistanceOutSuccess).assistanceOutList;
    final selectedCounter = (state as AssistanceOutSuccess).selectedCounter;
    if (isSelected) {
      emit(AssistanceOutSuccess([...assistanceOutList, assistanceOut], selectedCounter + 1));
    } else {
      emit(AssistanceOutSuccess(assistanceOutList.where((out) => out.id != assistanceOut.id).toList(), selectedCounter - 1));
    }
  }

  void clearSelectedAssistanceOut() {
    emit(AssistanceOutSuccess([], 0));
  }
}
