part of 'user_auth_bloc.dart';

@immutable
sealed class UserAuthEvent {}


class AuthRegisterButton extends UserAuthEvent{
  final String username;
  final String email;
  final String password;

  AuthRegisterButton({required this.username, required this.email, required this.password});

}
class AuthLoginButton extends UserAuthEvent{

  final String email;
  final String password;

  AuthLoginButton({required this.email, required this.password});

}