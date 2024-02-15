part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterUserLoadedState extends RegisterState {}

class RegisterUserSuccessState extends RegisterState {
  final WriteResult writeResult;

  RegisterUserSuccessState({required this.writeResult});
}

class RegisterUserFailedState extends RegisterState {
  final String error;

  RegisterUserFailedState({required this.error});
}
