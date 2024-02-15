import 'package:flutter/material.dart';

import '../widget/layer_four.dart';
import '../widget/layer_one.dart';
import '../widget/layer_two.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: Container(
        height: 1030,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/primaryBg.png'),
              fit: BoxFit.cover,
            )),
        child: Stack(
          children: <Widget>[
            const Positioned(
                top: 100,
                left: 50,
                child: Text(
                  'Create \nAccount',
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Poppins-Medium',
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                )),
            const Positioned(top: 290, right: 0, bottom: 0, child: LayerOne()),
            const Positioned(top: 318, right: 0, bottom: 0, child: LayerTwo()),
            Positioned(top: 320, right: 0, bottom: 0, child: LayerFour(buildContext: context)),
          ],
        ),
      )),
    );
  }
}