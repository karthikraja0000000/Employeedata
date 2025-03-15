part of 'employees_bloc.dart';

@immutable
abstract class EmployeesEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchAllEmployee extends EmployeesEvent{
  final String email;

  FetchAllEmployee(this.email);

  @override
  List<Object> get props => [email];
}
class AddEmployee extends EmployeesEvent{
  final String email;
  final String age;
  final String name;

  AddEmployee({required this.email, required this.age, required this.name, });

  @override
  List<Object> get props => [email,age,name];
}



class EditEmployee extends EmployeesEvent{

  final String name;
  final String age;
  final String email;
  final int id;

  EditEmployee({required this.name, required this.age,required this.id, required this.email});

  @override
  List<Object> get props => [name, age, email,id];

}
class DeleteEmployee extends EmployeesEvent{
  final int id;
  final String email;

  DeleteEmployee(this.id, this.email);

  @override
  List<Object> get props => [id,email];
}
class Logout extends EmployeesEvent{

}
