import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_polygon/const.dart';
import 'package:sobol_polygon/data/provider.dart';

//*виджет отображаемой точки многоугольника
class GraphicalPoint extends ConsumerWidget {
  final Offset offset;

  const GraphicalPoint({super.key, required this.offset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isPolygon = ref.watch(isPolygonProvider);

    return Positioned(
      left: offset.dx - 5,
      top: offset.dy - 5,
      child: IgnorePointer(
        child: Container(
          width: kRadiusGraphicalPoint,
          height: kRadiusGraphicalPoint,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isPolygon ? kColorPointPolygon : kColorPoint,
            border: Border.all(
              // strokeAlign: BorderSide.strokeAlignOutside,
              width: isPolygon ? kPointBorderPolygon : kPointBorder,
              color: isPolygon ? kColorPointBorderPolygon : kColorPointBorder,
            ),
          ),
        ),
      ),
    );
  }
}
