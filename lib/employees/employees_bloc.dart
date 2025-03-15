import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../database/employee_repository.dart';

part 'employees_event.dart';
part 'employees_state.dart';

class EmployeesBloc extends Bloc<EmployeesEvent, EmployeesState> {
  final EmployeeRepository employeeRepository;
  EmployeesBloc({required this.employeeRepository})
    : super(EmployeesInitial()) {
    on<FetchAllEmployee>((event, emit) async {
      try {
        final allUsers = await employeeRepository.fetchEmployee(event.email);
        emit(HomePageSuccess(allUsers));
      } catch (e) {
        emit(HomePageFailure("An error occurred: ${e.toString()}"));
      }
    });
    on<AddEmployee>((event, emit) async {
      final result = await employeeRepository.addEmployeeData(
        event.email,
        event.name,
        event.age,
      );
      if (result != -1) {
        emit(AddEmployeePageSuccess(event.email));
      } else {
        emit(AddEmployeePageFailure("error in adding values"));
      }
    });
    on<EditEmployee>((event, emit) async {
      final result = await employeeRepository.editEmployeeData(
        event.email,
        event.name,
        event.age,
        event.id,
      );
      if(result != -1){
        emit(EditEmployeePageSuccess(event.email));
      }
      else{
        emit(EditEmployeePageFailure("error in update values"));
      }
    });
    on<DeleteEmployee>((event, emit)async{
      try {
        await employeeRepository.deleteEmployeeData(
            event.id , event.email);
        final employees = await employeeRepository.fetchEmployee(event.email);
      emit(HomePageSuccess(employees));
      }
      catch(e){
          emit(HomePageFailure("error in deleting user"));
      }
    });
  }
}
