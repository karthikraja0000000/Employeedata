part of 'user_auth_bloc.dart';

@immutable
sealed class UserAuthState {}

class UserAuthInitialState extends UserAuthState {}


final class LoginPageInitial extends UserAuthState{}
final class LoginPageLoading extends UserAuthState{}
final class LoginPageSuccess extends UserAuthState{
  final String email;
  LoginPageSuccess({required this.email});
}
final class LoginPageFailed extends UserAuthState{
  final String error;
  LoginPageFailed({required this.error});
}


final class RegisterPageInitial extends UserAuthState{}
final class RegisterPageLoading extends UserAuthState{}
final class RegisterPageSuccess extends UserAuthState{
  final String email;

  RegisterPageSuccess({required this.email});
}
final class RegisterPageFailed extends UserAuthState{
  final String error;

  RegisterPageFailed({required this.error});
}