part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterUserDataEvent extends RegisterEvent {
  final String userName,
      userEmail,
      userPassword,
      userConfirmPassword,
      userPhone;

  RegisterUserDataEvent(
      {required this.userName,
      required this.userEmail,
      required this.userPassword,
      required this.userConfirmPassword,
      required this.userPhone});
}
