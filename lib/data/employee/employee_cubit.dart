import 'package:BTechApp_Final_Project/models/employee_model.dart';
import 'package:BTechApp_Final_Project/repository/EmployeeRepository.dart';
import 'package:bloc/bloc.dart';

import 'employee_state.dart';



class EmployeeCubit extends Cubit<EmployeeState> {
final EmployeeRepository _employeeRepository;

  EmployeeCubit(this._employeeRepository) : super(EmployeeInitial());


  void loadEmployees() async{

    try{
      final employees = await _employeeRepository.getAll();
      emit(EmployeeLoaded(employees));
    }catch (e){
      emit(EmployeeError(e.toString()));

    }
  }

  void add (Employee employee) async{
    try{
      await _employeeRepository.insert(employee);
      final employees = await _employeeRepository.getAll();
      emit(EmployeeLoaded(employees));

    }catch(e){
      emit(EmployeeError(e.toString()));
    }
  }

  void update(Employee employee) async{

    try{
      await _employeeRepository.update(employee);
      final employees = await _employeeRepository.getAll();
      emit(EmployeeLoaded(employees));
    }catch(e){
      emit(EmployeeError(e.toString()));
    }
  }

void delete(String nik) async{

  try{
    await _employeeRepository.deleteById(nik);
    final employees = await _employeeRepository.getAll();
    emit(EmployeeLoaded(employees));
  }catch(e){
    emit(EmployeeError(e.toString()));
  }
}
}
