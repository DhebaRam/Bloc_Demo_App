import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_config.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  const TitleText(
      {Key? key,
        this.text,
        this.fontSize = 18,
        this.color = titleTextColor,
        this.fontWeight = FontWeight.w800})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(text ??'',
        style: GoogleFonts.mulish(
            fontSize: fontSize, fontWeight: fontWeight, color: color));
  }
}