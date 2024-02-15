import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/auth/ragister_bloc/register_bloc.dart';

import '../../common/loader_widget.dart';
import '../../routers/app_routers.dart';
import '../../utis/color_config.dart';

class LayerFour extends StatefulWidget {
  final BuildContext? buildContext;

  const LayerFour({super.key, this.buildContext});

  @override
  State<LayerFour> createState() => _LayerFourState();
}

class _LayerFourState extends State<LayerFour> {
  final userNameController = TextEditingController(),
      userEmailController = TextEditingController(),
      userPhoneController = TextEditingController(),
      passwordController = TextEditingController(),
      confirmController = TextEditingController(),
      userImageController = TextEditingController();

  @override
  Widget build(buildContext) {
    bool isChecked = false;

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) async {
        print('Bloc Condition ---> ${state is RegisterUserLoadedState &&
            state is! RegisterUserFailedState}');
        if (state is RegisterUserLoadedState &&
            state is! RegisterUserFailedState) {
          onLoading(context);
        }else{
          Navigator.of(context).pop();
        }
        if (state is RegisterUserFailedState &&
            state is! RegisterUserLoadedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
        if (state is RegisterUserSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
            'You are successful sign-up',
          )));
          Navigator.of(context).pushNamed(AppRoutes.loginRoute);
        }
      },
      builder: (context, state) {
        return Container(
            // height: 1000,
            width: MediaQuery.of(buildContext).size.width,
            padding: const EdgeInsets.only(left: 50, right: 25),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Username',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: userNameController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter User ID or Email',
                        hintStyle: TextStyle(color: hintText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 59,
                    height: 8,
                  ),
                  const Text(
                    'User Email',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: userEmailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter User Email',
                        hintStyle: TextStyle(color: hintText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 59,
                    height: 8,
                  ),
                  const Text(
                    'User Phone',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: userPhoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter User Phone',
                        hintStyle: TextStyle(color: hintText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 59,
                    height: 8,
                  ),
                  const Text(
                    'Password',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: hintText),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 59,
                    height: 8,
                  ),
                  const Text(
                    'Confirm Password',
                    style: TextStyle(
                        fontFamily: 'Poppins-Medium',
                        fontSize: 24,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      controller: confirmController,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Enter Confirm Password',
                        hintStyle: TextStyle(color: hintText),
                      ),
                    ),
                  ),
                  // Container(
                  //     alignment: Alignment.centerRight,
                  //     padding: const EdgeInsets.only(top: 15),
                  //     child: const Text(
                  //       'Forgot Password',
                  //       style: TextStyle(
                  //           color: forgotPasswordText,
                  //           fontSize: 16,
                  //           fontFamily: 'Poppins-Medium',
                  //           fontWeight: FontWeight.w600),
                  //     )),
                  const SizedBox(
                    width: 59,
                    height: 8,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.black,
                        activeColor: checkbox,
                        value: isChecked,
                        onChanged: (bool? value) {
                          isChecked = value!;
                        },
                      ),
                      const Text(
                        'Terms and conditions',
                        style: TextStyle(
                            color: forgotPasswordText,
                            fontSize: 16,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      InkWell(
                          onTap: () {
                            context.read<RegisterBloc>().add(
                                RegisterUserDataEvent(
                                    userName: userEmailController.text.trim(),
                                    userEmail: userEmailController.text.trim(),
                                    userPhone: userPhoneController.text.trim(),
                                    userPassword:
                                        passwordController.text.trim(),
                                    userConfirmPassword:
                                        confirmController.text.trim()));
                            // Navigator.of(context).pushNamed(AppRoutes.loginRoute);
                            // CreateUserModel CreateUserModel = CreateUserModel(
                            //   userEmail: userEmailController.text.trim(),
                            //   userPassword: passwordController.text.trim(),
                            //
                            // );
                            // MongodbDataBase.createUser(CreateUserModel);
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
                                'Sign Up',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Poppins-Medium',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ))
                    ],
                  ),
                  SizedBox(
                    width: 59,
                    height: MediaQuery.of(context).size.width * 0.29,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.loginRoute);
                      },
                      child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 15),
                          child: const Text(
                            'Already have an account? Log in',
                            style: TextStyle(
                                color: forgotPasswordText,
                                fontSize: 16,
                                fontFamily: 'Poppins-Medium',
                                fontWeight: FontWeight.w600),
                          ))),
                  // Container(
                  //   height: 0.5,
                  //   width: MediaQuery.of(context).size.width * 0.7,
                  //   color: inputBorder,
                  // ),
                  // const SizedBox(
                  //   width: 59,
                  //   height: 18,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   children: <Widget>[
                  //     Container(
                  //       width: 59,
                  //       height: 48,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: signInBox),
                  //           borderRadius: const BorderRadius.only(
                  //               topLeft: Radius.circular(20),
                  //               bottomRight: Radius.circular(20))),
                  //       child: Image.asset(
                  //         'assets/images/icon_google.png',
                  //         width: 20,
                  //         height: 21,
                  //       ),
                  //     ),
                  //     const Text(
                  //       'or',
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontFamily: 'Poppins-Regular',
                  //           color: hintText),
                  //     ),
                  //     Container(
                  //       width: 59,
                  //       height: 48,
                  //       decoration: BoxDecoration(
                  //           border: Border.all(color: signInBox),
                  //           borderRadius: const BorderRadius.only(
                  //               topLeft: Radius.circular(20),
                  //               bottomRight: Radius.circular(20))),
                  //       child: Image.asset(
                  //         'assets/images/icon_apple.png',
                  //         width: 20,
                  //         height: 21,
                  //       ),
                  //     ),
                  //   ],
                  // )
                ]));
      },
    );
  }
}
