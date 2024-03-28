import 'package:flutter/material.dart';

//*отрисовка динамически изменяемой линию от последней точки до курсора
class DrawDynamicLine extends CustomPainter {
  final Offset pointer;
  final List<Offset> points;

  DrawDynamicLine({required this.points, required this.pointer});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    if (points.isNotEmpty) {
      canvas.drawLine(points.last, pointer, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DrawDynamicLine oldDelegate) => true;
}
