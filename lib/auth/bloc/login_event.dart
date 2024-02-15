part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginAuthEvent extends LoginEvent{
  final String userEmail, password;

  LoginAuthEvent({required this.userEmail, required this.password});
}