import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:sobol_polygon/const.dart';
import 'package:sobol_polygon/widgets/custom_cursor.dart';
import 'package:sobol_polygon/widgets/graphical_point.dart';

bool isPolygon = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //*массив где храним точки многоугольника
  List<Offset> points = [];

  //*массив виджетов для отрисовки точек
  List<Widget> graphicalPoints = [];

  //*добавление новой точки многоугольника
  void _addPoint(event) {
    setState(() {
      if (!isPolygon) {
        points.add(event.localPosition);
        graphicalPoints.add(GraphicalPoint(offset: event.localPosition));
      }
    });
    print('Point added at: x:${points.last.dx}, y:${points.last.dy}');
  }

  //*pointer mouse coordinates
  Offset pointer = Offset.zero;

  //*апдейт местоположения курсора
  void _onMouseHover(event) {
    setState(() {
      pointer = event.position;
    });
    // print('current cursor position: ${pointer.dx}, ${pointer.dy}');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kColorCanvas,
      body: MouseRegion(
        cursor: SystemMouseCursors.none,
        onHover: _onMouseHover,
        child: GestureDetector(
          onPanDown: _addPoint,
          child: Stack(
            children: [
              //*polygon
              CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: DrawPolygon(points: points),
              ),

              //*динамически изменяемая линия
              if (!isPolygon)
                CustomPaint(
                  size: Size(screenWidth, screenHeight),
                  painter: DrawDynamicLine(
                    points: points,
                    pointer: pointer,
                  ),
                ),

              //*линии из точек
              CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: DrawLinesPainter(points),
              ),

              //*точки из массива графических точек виджета GraphicalPoint.
              ...graphicalPoints,

              //*этот сложный курсор
              CustomCursor(pointer: pointer),
            ],
          ),
        ),
      ),
    );
  }
}

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

//*polygon
class DrawPolygon extends CustomPainter {
  final List<Offset> points;
  DrawPolygon({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = kStrokeWidth
      ..style = PaintingStyle.fill;

    //*если последняя точка совпадает с первой то создать прямоугольник с цветом
    if (points.length > 1 &&
        (points.first >= Offset(points.last.dx - 10, points.last.dy - 10) &&
            points.first <= Offset(points.last.dx + 10, points.last.dy + 10))) {
      isPolygon = true;
      print('polygon!');
      //*draw polygon
      // final polygonPoints = points;
      canvas.drawPath(Path()..addPolygon(points, true), paint);
    }
  }

  @override
  bool shouldRepaint(covariant DrawPolygon oldDelegate) => true;
}
//polygon end

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
