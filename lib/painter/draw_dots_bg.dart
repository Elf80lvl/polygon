// import 'package:flutter/material.dart';
// import 'package:sobol_polygon/const.dart';

// class DrawDotsBg extends CustomPainter {
//   DrawDotsBg();

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = kColorDotsBG
//       ..strokeWidth = 1
//       ..style = PaintingStyle.fill
//       ..strokeCap = StrokeCap.round
//       ..strokeJoin = StrokeJoin.round;

//     final int dotsBgSize = 1000;
//     final int step = 25;

//     List<Offset> dotsBg = [];

//     for (int i = 1; i <= 100; step) {
//       dotsBg.add(Offset(i as double, i as double));
//     }

//     print(dotsBg);

//     Path path = Path();
//     // dotsBg.forEach((element) {
//     //   path.addOval(Rect.fromCircle(center: element, radius: 2));
//     // });

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant DrawDotsBg oldDelegate) => true;
// }
