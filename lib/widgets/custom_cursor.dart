import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sobol_polygon/const.dart';

const _cursorRadius = 10.0;
const _arrowLength = 14.0;

class CustomCursor extends StatelessWidget {
  const CustomCursor({
    super.key,
    required this.pointer,
  });

  final Offset pointer;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // duration: const Duration(milliseconds: 100),
      left: pointer.dx - _cursorRadius / 2,
      top: pointer.dy - _cursorRadius / 2,
      child: IgnorePointer(
        child: Stack(
          children: [
            const ArrowCustom(quarterTurns: 0),

            const ArrowCustom(quarterTurns: 1),

            const ArrowCustom(quarterTurns: 2),

            const ArrowCustom(quarterTurns: 3),

            //*center
            Container(
              height: _cursorRadius,
              width: _cursorRadius,
              decoration: BoxDecoration(
                color: const Color(0xffFDFDFD),
                borderRadius: const BorderRadius.all(
                  Radius.circular(_cursorRadius),
                ),
                border: Border.all(
                  width: 1.77,
                  color: const Color(0xff377BBB),
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArrowCustom extends StatelessWidget {
  final int quarterTurns;
  const ArrowCustom({
    super.key,
    required this.quarterTurns,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _cursorRadius / 2,
      left: _cursorRadius / 2,
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: CustomPaint(
          painter: ArrowPainter(),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kColorCursor
      ..strokeWidth = 3.53
      ..strokeCap = StrokeCap.round;

    final p1 = const Offset(0, 0);
    final p2 = const Offset(_arrowLength, 0);

    //*arrow line top
    final arrowTopLinePoint1 = p2;
    final arrowTopLinePoint2 = const Offset(_arrowLength - 3, 0 - 3);
    canvas.drawLine(arrowTopLinePoint1, arrowTopLinePoint2, paint);
    //*arrow line bottom
    final arrowBottomLinePoint1 = p2;
    final arrowBottomLinePoint2 = const Offset(_arrowLength - 3, 0 + 3);
    canvas.drawLine(arrowBottomLinePoint1, arrowBottomLinePoint2, paint);

    //*line
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
