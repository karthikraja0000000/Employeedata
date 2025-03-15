part of 'employees_bloc.dart';

@immutable
abstract class EmployeesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class EmployeesInitial extends EmployeesState {}

final class HomePageLoading extends EmployeesState {}

final class HomePageSuccess extends EmployeesState {
  final List<Map<String, dynamic>> allUsers;

  HomePageSuccess(this.allUsers);

  @override
  List<Object> get props => [allUsers];
}

final class HomePageFailure extends EmployeesState {
  final String error;

  HomePageFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class AddEmployeePageLoading extends EmployeesState {}

final class AddEmployeePageSuccess extends EmployeesState {
  final String email;

  AddEmployeePageSuccess(this.email);
}

final class AddEmployeePageFailure extends EmployeesState {
  final String error;
  AddEmployeePageFailure(this.error);
}

final class EditEmployeePageLoading extends EmployeesState {}

final class EditEmployeePageSuccess extends EmployeesState {
  final String email;

  EditEmployeePageSuccess(this.email);
}

final class EditEmployeePageFailure extends EmployeesState {
  final String error;
  EditEmployeePageFailure(this.error);
}
