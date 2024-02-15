// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:untitled/auth/bloc/login_bloc.dart';

import '../../common/loader_widget.dart';
import '../../routers/app_routers.dart';
import '../../utis/color_config.dart';
import '../widget/layer_one.dart';
import '../widget/layer_three.dart';
import '../widget/layer_two.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is AuthLoaderState && state is! AuthFailedState) {
          onLoading(context);
        }else{
          Navigator.of(context).pop();
        }
        print('Loginn---> ${state is AuthFailedState && state is! AuthLoaderState}');
        if (state is AuthFailedState && state is! AuthLoaderState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
        if (state is AuthSuccessState) {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setBool('login', true);
          Navigator.of(context).pushNamed(AppRoutes.customBottomNavRoute);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/primaryBg.png'),
            fit: BoxFit.cover,
          )),
          child: Stack(
            children: <Widget>[
              Positioned(
                  top: 15.h,
                  left: 59,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 48,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              Positioned(top: 32.h, right: 0, bottom: 0, child: LayerOne()),
              Positioned(top: 36.h, right: 0, bottom: 0, child: LayerTwo()),
              Positioned(top: 40.h, right: 0, bottom: 0, child: LayerThree()),
            ],
          ),
        )),
      ),
    );
  }
}
