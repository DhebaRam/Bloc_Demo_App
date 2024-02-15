import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_config.dart';


// final LocalStorage localStorage = LocalStorage.localStorageSharedInstanace;

showCustomDialog(
  context, {
  required String title,
  List<Widget> children = const [],
  double height = 200,
  padding = const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
  bool isCenter = true,
  bool isTitleCenter = true,
  TextStyle? titleStyle,
  double borderWidth = 3,
  double borderRadius = 15,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        // backgroundColor: ColorConstants.white,
        shape: RoundedRectangleBorder(
            side: const BorderSide(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        insetPadding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(width: 3, color: skyBlue),
              gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    skyBlue,
                    skyBlue
                  ])),
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: EdgeInsetsDirectional.only(top: 0.sp),
                  child: Padding(
                    padding: padding,
                    child: Column(
                      crossAxisAlignment: isCenter
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: children,
                    ),
                  ),
                ),
                Align(
                  alignment: isTitleCenter
                      ? Alignment.center
                      : const Alignment(-0.8, -0.9),
                  heightFactor: 1,
                  child: Container(
                    padding: EdgeInsetsDirectional.only(
                        top: 10.sp, start: 20.sp, end: 20.sp),
                    child: Text(
                      title,
                      textAlign:
                          isTitleCenter ? TextAlign.center : TextAlign.left,
                      style: titleStyle ??
                          GoogleFonts.workSans(
                            fontSize: 20.sp,
                            color: whiteColor,
                            fontWeight: FontWeight.w500,
                            // fontFamily: FontFamily.arial,
                          ),
                    ),
                  ),
                ),
                Positioned.directional(
                  textDirection: Directionality.of(context),
                  top: -15,
                  end: -15,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(Icons.close, size: 20, color: blackColor,),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
