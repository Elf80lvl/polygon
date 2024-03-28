import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_polygon/const.dart';
import 'package:sobol_polygon/data/provider.dart';
import 'package:sobol_polygon/painter/draw_dynamic_line_painter.dart';
import 'package:sobol_polygon/painter/draw_lines_painter.dart';
import 'package:sobol_polygon/painter/draw_polygon_painter.dart';
import 'package:sobol_polygon/widgets/app_bar_custom.dart';
import 'package:sobol_polygon/widgets/buttons_widget.dart';
import 'package:sobol_polygon/widgets/custom_cursor.dart';
import 'package:sobol_polygon/widgets/fab_custom.dart';
import 'package:sobol_polygon/widgets/graphical_point.dart';

class HomePage2 extends ConsumerWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var points = ref.watch(pointsProvider);
    var isPolygon = ref.watch(isPolygonProvider);
    var cursorPosition = ref.watch(cursorPositionProvider);
    var graphicalPoints = ref.watch(graphicalPointsProvider);
    var isButtonsOnHover = ref.watch(isButtonsOnHoverProvider);
    var historyPoints = ref.watch(historyPointsProvider);
    var currentIndexHistory = ref.watch(currentIndexHistoryProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kHeightAppBar),
        child: AppBarCustom(),
      ),
      backgroundColor: kColorCanvas,
      body: MouseRegion(
        cursor: isPolygon ? SystemMouseCursors.basic : SystemMouseCursors.none,
        onHover: (event) {
          ref.read(cursorPositionProvider.notifier).state = event.localPosition;
        },
        child: GestureDetector(
          onPanDown: (event) {
            //*если не полигон то добавить следующую точку координат и графическую точку
            if (!isPolygon && !isButtonsOnHover) {
              ref.read(pointsProvider.notifier).state.add(event.localPosition);
              ref
                  .read(graphicalPointsProvider.notifier)
                  .state
                  .add(GraphicalPoint(offset: event.localPosition));
              ref.read(historyPointsProvider.notifier).state = points;
              print('history: $historyPoints');
              ref.read(currentIndexHistoryProvider.notifier).state =
                  points.length;
              print('current index: $currentIndexHistory');
            }

            //*получился ли полигон
            if (points.length > 1 &&
                (points.first >=
                        Offset(points.last.dx - 10, points.last.dy - 10) &&
                    points.first <=
                        Offset(points.last.dx + 10, points.last.dy + 10))) {
              print('polygon!');
              ref.read(isPolygonProvider.notifier).state = true;
              ref.read(graphicalPointsProvider.notifier).state.removeLast();
            }
          },
          child: Stack(
            children: [
              //*polygon
              if (isPolygon)
                CustomPaint(
                  size: Size(screenWidth, screenHeight),
                  painter: DrawPolygon(points: points),
                ),

              //*динамически изменяемая линия от последней точки до курсора
              if (!isPolygon && !isButtonsOnHover)
                CustomPaint(
                  size: Size(screenWidth, screenHeight),
                  painter: DrawDynamicLine(
                    points: points,
                    pointer: cursorPosition,
                  ),
                ),

              //*линии из точек
              CustomPaint(
                size: Size(screenWidth, screenHeight),
                painter: DrawLinesPainter(points),
              ),

              //*точки из массива графических точек виджета GraphicalPoint.
              ...graphicalPoints,

              //*курсор
              if (!isButtonsOnHover && !isPolygon)
                CustomCursor(pointer: cursorPosition),

              //*buttons
              const ButtonsWidget(),
            ],
          ),
        ),
      ),
      //*snap to grid button
      floatingActionButton: const FabCustom(),
    );
  }
}
