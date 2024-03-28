import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:sobol_polygon/const.dart';

//*класс для отрисовки многоуольника
class DrawLinesPainter extends CustomPainter {
  final List<Offset> points;
  DrawLinesPainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final pointMode = ui.PointMode.polygon;
    final paint = Paint()
      ..color = kColorLines
      ..strokeWidth = kStrokeWidth
      ..style = PaintingStyle.stroke;
    //*отрисовка новой фигуры если есть более 1 точки
    if (points.length > 1) {
      canvas.drawPoints(pointMode, points, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DrawLinesPainter oldDelegate) => true;
}
