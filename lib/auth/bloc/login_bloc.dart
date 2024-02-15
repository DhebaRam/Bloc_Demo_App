import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/auth/repo/auth_repo.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginAuthEvent>(_loginAuthCalled);
  }

  FutureOr<void> _loginAuthCalled(
      LoginAuthEvent event, Emitter<LoginState> emit) async {
    try {
      if (event.userEmail.trim().isEmpty || event.password.trim().isEmpty) {
        return emit(
          AuthFailedState(error: 'Required Field'),
        );
      }
      final emailValid = (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(event.userEmail));
      if (!emailValid) {
        return emit(AuthFailedState(error: 'Please enter valid emil'));
      }
      if (event.password.length < 6) {
        return emit(
          AuthFailedState(error: 'Password cannot be less than 6 characters!'),
        );
      }
      emit(AuthLoaderState());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      await Future.delayed(const Duration(seconds: 2), () {});
      final result = await AuthRepos().loginUser(event);
      print('sdffsafgd ${result != null}' );
      if (result != null && result['status']) {
        sharedPreferences.setString('UserEmail', event.userEmail);
        emit(AuthSuccessState());
      } else {
        emit(AuthFailedState(error: result?['message']));
      }
      // final response = await AuthRepos().authLogin(map);
      // final authData = response.data;
    } catch (e) {
      emit(AuthFailedState(error: e.toString()));
      log(e.toString());
    }
  }
}
