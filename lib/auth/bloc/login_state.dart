part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class AuthLoaderState extends LoginState {}
class AuthSuccessState extends LoginState{}
class AuthFailedState extends LoginState{
  final String error;
  AuthFailedState({required this.error});
}
