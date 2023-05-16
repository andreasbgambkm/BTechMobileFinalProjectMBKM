

import 'package:BTechApp_Final_Project/models/employee_model.dart';
import 'package:equatable/equatable.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object> get props => [];
}

class EmployeeInitial extends EmployeeState {

}



class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;

  EmployeeLoaded(this.employees);

  @override
  // TODO: implement props
  List<Object> get props => [employees];
}

class EmployeeError extends EmployeeState {
  final String message;

  EmployeeError(this.message);
}
