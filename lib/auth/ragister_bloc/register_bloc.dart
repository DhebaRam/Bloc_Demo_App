import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../repo/auth_repo.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterUserDataEvent>(_registerUserCalled);
  }

  Future<void> _registerUserCalled(
      RegisterUserDataEvent event, Emitter<RegisterState> emit) async {
    try {
      final emailValid = (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(event.userEmail));
      if (event.userName.trim().isEmpty ||
          event.userPassword.trim().isEmpty ||
          event.userEmail.trim().isEmpty ||
          event.userPhone.trim().isEmpty) {
        return emit(
          RegisterUserFailedState(error: 'Required Field'),
        );
      }
      if (!emailValid) {
        return emit(RegisterUserFailedState(error: 'Please enter valid emil'));
      }
      if (event.userPassword != event.userConfirmPassword) {
        return emit(RegisterUserFailedState(error: 'Password is not match'));
      }
      if (event.userPassword.length < 6) {
        return emit(
          RegisterUserFailedState(
              error: 'Password cannot be less than 6 characters!'),
        );
      }

      emit(RegisterUserLoadedState());
      await Future.delayed(const Duration(seconds: 2), () {});
      WriteResult result = await AuthRepos().registerUser(event);
      print(result.isSuccess);
      print(result.writeError?.errmsg);
      if (result.isSuccess) {
        emit(RegisterUserSuccessState(writeResult: result));
      }
      else {
        if (result.writeError?.code == 11000) {
          final duplicateKey = result.writeError?.errmsg?.split('dup key: ')[1];
          print('Duplicate key value: $duplicateKey');
          emit(RegisterUserFailedState(error: 'Duplicate key value:${duplicateKey.toString()}'));
        }else {
          emit(RegisterUserFailedState(
              error: result.writeError?.errmsg.toString() ??
                  'Something went wrong'));
        }
      }
    } catch (e) {
      emit(RegisterUserFailedState(error: e.toString()));
    }
  }
}
