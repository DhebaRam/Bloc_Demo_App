import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pay/pay.dart';
import 'package:sizer/sizer.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool pay = true, googlePayVisible = false, visa = false;
  late Future<bool> _userCanPay;
  Pay payClient = Pay.withAssets(['gpay.json']);

  @override
  void initState() {
    _userCanPay = payClient.userCanPay(PayProvider.google_pay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            automaticallyImplyLeading: true,
            iconTheme:
                const IconThemeData(color: Colors.white //change your color here
                    ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF26CBE6),
                Color(0xFF26CBE0),
                Color(0xFF26CBD6),
                Color(0xFF26CBD0),
                Color(0xFF26CBC0),
              ], begin: Alignment.topCenter, end: Alignment.center)),
            ),
            actions: const [
              // IconButton(
              //   icon: const Icon(Icons.add_shopping_cart,
              //       size: 26, weight: 0.01, color: Colors.white),
              //   onPressed: () {
              //
              //     // showBottomSheetWidget(context: context);
              //   },
              // ),
              SizedBox(width: 10)
            ],
            title: Text('Payment Method',
                    style: GoogleFonts.kanit().copyWith(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center)
                .animate(onPlay: (controller) => controller.repeat()),
            // .shimmer(duration: 120000.ms, color: const Color(0xFF80DDFF))
            // .animate() // this wraps the previous Animate in another Animate
            // .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
            // .slide(),
            centerTitle: true),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
                child: ListView(
              children: [
                buildPayButtons(() {
                  setState(() {
                    pay = true;
                    googlePayVisible = false;
                    visa = false;
                  });
                }, 'Pay', pay),
                buildPayButtons(() {
                  setState(() {
                    pay = false;
                    googlePayVisible = true;
                    visa = false;
                  });
                }, 'Google Pay', googlePayVisible),
                buildPayButtons(() {
                  setState(() {
                    pay = false;
                    googlePayVisible = false;
                    visa = true;
                  });
                }, 'Visa', visa),
              ],
            )),

            ///Google pay implement Success.
            // GooglePayButton(
            //   paymentConfigurationAsset: 'gpay.json',
            //   paymentItems: const [
            //     PaymentItem(
            //       label: 'Total',
            //       amount: '10.00',
            //       status: PaymentItemStatus.final_price,
            //     )
            //   ],
            //   type: GooglePayButtonType.pay,
            //   margin: const EdgeInsets.only(top: 15.0),
            //   onPaymentResult: (result) {
            //     log('Payment Result ----> ${result.toString()}');
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(
            //         content: Text('Payment Successful Pay'),
            //       ),
            //     );
            //   },
            //   onError: (result){
            //     print('object----- > ${result.toString()}');
            //   },
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            const SizedBox(height: 20),
            Visibility(
                visible: Platform.isAndroid,
                child: GestureDetector(
                    onTap: () async {
                      if (googlePayVisible == true) {
                        googlePayWidget();
                      }
                      if(visa == true){
                        madaPayWidget();
                      }
                    },
                    child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.sp, vertical: 10),
                        decoration: BoxDecoration(
                          color: Color(0xFF26CBC0),
                          borderRadius: BorderRadius.circular(15.sp),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 0.5.sp,
                                blurRadius: 4.sp)
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Continue',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700))
                          ],
                        )))),
            const SizedBox(height: 20),
          ],
        ));
  }

  void googlePayWidget() async {
    _userCanPay = payClient.userCanPay(PayProvider.google_pay);
    log("${await _userCanPay}");
    if (await _userCanPay) {
      final result = await payClient.showPaymentSelector(
        PayProvider.google_pay,
        // provider: PayProvider.google_pay,
        [
          const PaymentItem(
            amount: '50.00',
            status: PaymentItemStatus.final_price,
          )
        ],
      );
      log(result.toString());
    }
  }

  Future<void> madaPayWidget() async {

  }
}

buildPayButtons(void Function()? onTap, String payIcon, bool radioIcon) {
  return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10),
          decoration: BoxDecoration(
            color: radioIcon ? const Color(0xFF26CBC0) : Colors.white,
            borderRadius: BorderRadius.circular(15.sp),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0.5.sp,
                  blurRadius: 4.sp)
            ],
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(payIcon,
                  style: TextStyle(
                      fontSize: 20,
                      color: radioIcon ? Colors.white : Colors.black,
                      fontWeight:
                          radioIcon ? FontWeight.w700 : FontWeight.w500))
            ],
          )));
}
