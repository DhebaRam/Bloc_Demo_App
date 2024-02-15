import 'package:flutter/material.dart';
import 'dart:ui' as ui;

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            // width: MediaQuery.of(context).size.width,
            // height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width,MediaQuery.of(context).size.height), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height),
                // child: Container(
                //   color: Colors.cyan,
                // )
              ),
            ],
          )
            // child: CustomPaint(
            //   size: Size.fromHeight(MediaQuery.of(context).size.height,),
            //   foregroundPainter: CurvePainter(),
            //   willChange: true,
            //   isComplex: false,
            // ),
        ));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xFFE32087)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.2, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter{
  final double height, width;

  RPSCustomPainter({super.repaint, required this.height, required this.width});
  @override
  void paint(Canvas canvas, Size size) {



    // Layer 1

    Paint paint_fill_0 = Paint()
      ..color = const Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;


    Path path_0 = Path();
    path_0.moveTo(width*0.1116667,height*0.3428571);
    path_0.lineTo(width*0.1808333,height*0.3457143);
    path_0.lineTo(width*0.2116667,height*0.2842857);
    path_0.lineTo(width*0.2975000,height*0.2800000);
    path_0.lineTo(width*0.3333333,height*0.3471429);
    path_0.lineTo(width,height*0.3514286);
    path_0.lineTo(width,height*0.7214286);
    path_0.lineTo(width*0.9250000,height*0.7157143);
    path_0.lineTo(width*0.8841667,height*0.7842857);
    path_0.lineTo(width*0.7008333,height*0.7871429);
    path_0.lineTo(width*0.6616667,height*0.7171429);
    path_0.lineTo(width*0.1116667,height*0.7171429);
    path_0.lineTo(width*0.1116667,height*0.3428571);
    path_0.close();

    canvas.drawPath(path_0, paint_fill_0);


    // Layer 1

    Paint paint_stroke_0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width*0.00
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;



    canvas.drawPath(path_0, paint_stroke_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
