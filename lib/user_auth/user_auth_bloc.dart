import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../database/employee_repository.dart';

part 'user_auth_event.dart';
part 'user_auth_state.dart';

class UserAuthBloc extends Bloc<UserAuthEvent, UserAuthState> {
  final EmployeeRepository employeeRepository;

  UserAuthBloc({required this.employeeRepository}) : super(UserAuthInitialState()) {
    on<AuthRegisterButton>((event, emit) async {
      final result = await employeeRepository.registerUser(
        event.email,
        event.username,
        event.password,
      );
      try {
        if (result != -1) {
          emit(RegisterPageSuccess(email: event.email));
        } else {
          emit(
            RegisterPageFailed(
              error: 'User Already Exists,Try with another email',
            ),
          );
        }
      } catch (e) {
        emit(RegisterPageFailed(error: "An error occurred: ${e.toString()}"));
      }
    });

    on<AuthLoginButton>((event, emit) async {
      print("Login event received: Email = ${event.email}, Password = ${event.password}");

      emit(LoginPageLoading());

      try {
        var isValidUser = await employeeRepository.loginUser(event.email, event.password);

        if (isValidUser != null && isValidUser.isNotEmpty ) {
          print("Login successful, emitting LoginPageSuccess state");
          emit(LoginPageSuccess(email: event.email));
          await employeeRepository.createEmployeeTable(event.email);
        } else {
          print("Login failed, emitting LoginPageFailed state");
          emit(LoginPageFailed(error: "Login Failed"));
        }
      } catch (e) {
        print("Exception during login: $e");
        emit(LoginPageFailed(
          error: "Exception error"
        ));
      }
    });
  }
}
