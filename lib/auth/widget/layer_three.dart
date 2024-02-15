import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../common/lower_case_widget.dart';
import '../../routers/app_routers.dart';
import '../../utis/color_config.dart';
import '../bloc/login_bloc.dart';

final userName = TextEditingController(), password = TextEditingController();

class LayerThree extends StatelessWidget {
  const LayerThree({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;

    return SingleChildScrollView(
        child: SizedBox(
      height: 60.h,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 59,
            top: 1.h,
            child: const Text(
              'Username',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: 59,
              top: 5.h,
              child: SizedBox(
                width: 310,
                child: TextField(
                  controller: userName,
                  inputFormatters: [LowerCaseTextFormatter()],
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter User ID or Email',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          Positioned(
            left: 59,
            top: 12.h,
            child: const Text(
              'Password',
              style: TextStyle(
                  fontFamily: 'Poppins-Medium',
                  fontSize: 24,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Positioned(
              left: 59,
              top: 16.h,
              child: Container(
                width: 310,
                child: TextField(
                  controller: password,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: hintText),
                  ),
                ),
              )),
          Positioned(
              right: 60,
              top: 25.h,
              child: const Text(
                'Forgot Password',
                style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 16,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w600),
              )),
          Positioned(
              left: 46,
              top: 29.h,
              child: Checkbox(
                checkColor: Colors.black,
                activeColor: checkbox,
                value: isChecked,
                onChanged: (bool? value) {
                  isChecked = value!;
                },
              )),
          Positioned(
              left: 87,
              top: 30.5.h,
              child: Text(
                'Remember Me',
                style: TextStyle(
                    color: forgotPasswordText,
                    fontSize: 16,
                    fontFamily: 'Poppins-Medium',
                    fontWeight: FontWeight.w500),
              )),
          Positioned(
              top: 30.h,
              right: 60,
              child: InkWell(
                  onTap: () {
                    context.read<LoginBloc>().add(LoginAuthEvent(
                        userEmail: userName.text.trim(),
                        password: password.text.trim()));
                  },
                  child: Container(
                    width: 99,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: signInButton,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 6.0),
                      child: Text(
                        'Sign In',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ))),
          Positioned(
              top: 35.h,
              left: 59,
              child: Container(
                height: 0.5,
                width: 310,
                color: inputBorder,
              )),
          Positioned(
              top: 40.h,
              left: 120,
              right: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 59,
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(color: signInBox),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Image.asset(
                      'assets/images/icon_google.png',
                      width: 20,
                      height: 21,
                    ),
                  ),
                  const Text(
                    'or',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Poppins-Regular',
                        color: hintText),
                  ),
                  Container(
                    width: 59,
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(color: signInBox),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Image.asset(
                      'assets/images/icon_apple.png',
                      width: 20,
                      height: 21,
                    ),
                  ),
                ],
              )),
          Positioned(
              top: 55.h,
              right: 0,
              left: 0,
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.registerRoute);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 15),
                      child: const Text(
                        'Don\'t have an account? Register now',
                        style: TextStyle(
                            color: forgotPasswordText,
                            fontSize: 16,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w600),
                      ))))
        ],
      ),
    ));
  }
}
