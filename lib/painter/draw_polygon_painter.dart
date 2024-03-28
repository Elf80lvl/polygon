import 'package:flutter/material.dart';
import 'package:sobol_polygon/const.dart';

//*отрисовка полигона
class DrawPolygon extends CustomPainter {
  final List<Offset> points;
  DrawPolygon({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = kStrokeWidth
      ..style = PaintingStyle.fill;

    //*так как мы попадаем примерно в первую точку
    //*убираем последнюю точку, которой попали не идеально и
    //*добавляем первую в конец чтобы замкнуть полигон
    points.removeLast();
    points.add(points[0]);
    //*polygon
    canvas.drawPath(Path()..addPolygon(points, true), paint);
  }

  @override
  bool shouldRepaint(covariant DrawPolygon oldDelegate) => true;
}
