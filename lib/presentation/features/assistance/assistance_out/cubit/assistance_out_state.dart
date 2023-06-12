part of 'assistance_out_cubit.dart';

abstract class AssistanceOutState {}

class AssistanceOutInitial extends AssistanceOutState {}

class AssistanceOutLoading extends AssistanceOutState {}

class AssistanceOutSuccess extends AssistanceOutState {
  final List<AssistanceOutModel> assistanceOutList;
  final int selectedCounter;

  AssistanceOutSuccess(this.assistanceOutList, this.selectedCounter);
}

class AssistanceOutError extends AssistanceOutState {
  final String errorMessage;

  AssistanceOutError(this.errorMessage);
}
