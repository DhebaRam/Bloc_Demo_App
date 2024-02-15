import 'package:flutter/material.dart';

import '../utis/color_config.dart';

Widget baseCardShadow(
    {VoidCallback? onTap,
    Widget child = const SizedBox(),
    double topLeftRadius = 10,
    double topRightRadius = 10,
    double bottomLeftRadius = 10,
    double bottomRightRadius = 10,
    Color? color,
    Color? containerFirst,
    Color? containerThird,
    Gradient? gradientFirst,
    Gradient? gradientSecond,
    Gradient? gradientThird,
    Color? borderColor,
    Color? borderSecond,
    Color? borderColorThird,
    double? borderWidthThird,
    Color? borderTopColorSecond,
    Color? borderRightColorSecond,
    Color? borderLeftColorSecond,
    Color? borderBottomColorSecond,
    double? height,
    double? width,
    double? borderWidth,
    double? borderTopWidthSecond,
    double? borderRightWidthSecond,
    double? borderLeftWidthSecond,
    double? borderBottomWidthSecond,
    double? secondLeft,
    double? firstBottomMargin,
    double? firstBottomPadding,
    secondRight,
    secondTop,
    secondBottom}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      height: height,
      margin: EdgeInsets.only(bottom: firstBottomMargin ?? 0),
      padding: EdgeInsets.only(top: 0.0, bottom: firstBottomPadding ?? 3.0),
      decoration: BoxDecoration(
          color: containerFirst ?? layerOneBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius)),
          gradient: gradientFirst ??
              const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    skyBlue,
                    lightBlue
                  ])),
      child: Container(
        clipBehavior: Clip.none,
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: gradientSecond ??
               const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                  colors: [skyBlue, lightBlue]),
          border: Border(
              top: BorderSide(
                  color: borderTopColorSecond ?? Colors.transparent,
                  width: borderTopWidthSecond ?? 0),
              bottom: BorderSide(
                  color: borderBottomColorSecond ?? Colors.transparent,
                  width: borderBottomWidthSecond ?? 0),
              left: BorderSide(
                  color: borderLeftColorSecond ?? Colors.transparent,
                  width: borderLeftWidthSecond ?? 0),
              right: BorderSide(
                  color: borderRightColorSecond ?? Colors.transparent,
                  width: borderRightWidthSecond ?? 0)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeftRadius),
              topRight: Radius.circular(topRightRadius),
              bottomLeft: Radius.circular(bottomLeftRadius),
              bottomRight: Radius.circular(bottomRightRadius)),
        ),
        child: Container(
            padding: EdgeInsets.only(
                left: secondLeft ?? 0,
                right: secondRight ?? 0,
                top: secondTop ?? 0,
                bottom: secondBottom ?? 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: containerThird ?? layerOneBg,
              border: Border.all(
                color: borderColorThird ?? Colors.transparent,
                width: borderWidthThird ?? 3,
              ),
              gradient: gradientThird ??
                   const LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        skyBlue,
                        layerOneBg
                      ]),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(topLeftRadius),
                  topRight: Radius.circular(topRightRadius),
                  bottomLeft: Radius.circular(bottomLeftRadius),
                  bottomRight: Radius.circular(bottomRightRadius)),
            ),
            child: Container(child: child)),
      ),
    ),
  );
}
