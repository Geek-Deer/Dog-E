import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Background extends StatelessWidget {

  final Widget child;
  final double height;


  const Background({Key? key, required this.child, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
        child: Stack(
        children: <Widget>[
          CustomPaint(
            size: Size(size.width, height),
              painter: BGCustomPainter(),
          ),
          child,
        ],
    ));
  }
}

class BGCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size){

    Path path = Path();
    path.moveTo(0,0);
    path.lineTo(size.width, 0);
    path.cubicTo(size.width * 0.9998692, 0, size.width * 1.000167, size.height * 0.4160673, size.width * 0.9996892, size.height * 0.4170404);
    path.cubicTo(size.width * 0.9537214, size.height * 0.4932735, size.width * 0.9383388, size.height * 0.5448430, size.width * 0.8127142, size.height * 0.6143498);
    path.cubicTo(size.width * 0.6870896, size.height * 0.6838565, size.width * 0.4542483, size.height * 0.6337220, size.width * 0.30400372, size.height * 0.788341);
    path.cubicTo(size.width * 0.1538260, size.height * 0.9439462, 0, size.height, 0, size.height);

    path.close();

    Paint paint = Paint()..style = PaintingStyle.fill;
    paint.shader = ui.Gradient.linear(
        Offset(size.width*0.05500000, size.height*0.05400000),
        Offset(size.width*0.5460000, size.height*0.9390000),
        [Color(0xFFFFA50E).withOpacity(1), Color(0xFFF26D2B).withOpacity(1)], [0,1]
    );

    canvas.drawShadow(path, Colors.black, 3.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate){
    return true;
  }
}


class BottomBGCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {


    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 243, 132, 33)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    paint0.shader = ui.Gradient.linear(Offset(size.width*0.50,size.height*0.00),Offset(size.width*1.00,size.height*1.00),[Color(0xffff5904),Color(0xffffb500)],[0.00,1.00]);

    Path path0 = Path();
    path0.moveTo(size.width*0.0046600,size.height*1.0031462);
    path0.quadraticBezierTo(size.width*0.1770800,size.height*0.8992861,size.width*0.2239000,size.height*0.8288359);
    path0.cubicTo(size.width*0.2969200,size.height*0.7725194,size.width*0.2692600,size.height*0.6348379,size.width*0.4618600,size.height*0.5380324);
    path0.cubicTo(size.width*0.5968600,size.height*0.5366409,size.width*0.6767200,size.height*0.2019845,size.width*0.8542800,size.height*0.1373911);
    path0.quadraticBezierTo(size.width*0.9655200,size.height*0.1263190,size.width,size.height*0.0012101);
    path0.lineTo(size.width*1.0020000,size.height*1.0031462);
    canvas.drawShadow(path0, Colors.black, 30, false);

    canvas.drawPath(path0, paint0);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}




