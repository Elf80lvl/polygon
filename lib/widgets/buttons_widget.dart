import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sobol_polygon/const.dart';
import 'package:sobol_polygon/data/provider.dart';
import 'package:sobol_polygon/widgets/button_custom.dart';

//*кнопки интерфейса, undo, redo ...
class ButtonsWidget extends ConsumerWidget {
  const ButtonsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var historyPoints = ref.watch(historyPointsProvider);
    var points = ref.watch(pointsProvider);
    var currentIndexHistory = ref.watch(currentIndexHistoryProvider);
    var isPolygon = ref.watch(isPolygonProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 8),
      child: Container(
        decoration: const BoxDecoration(
          color: kColorButtonsBG,
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //*button undo
            ButtonCustom(
              onTap: () {
                print('---');
                print('undo');
                if (isPolygon) {
                  ref.read(isPolygonProvider.notifier).state = false;
                }

                if (currentIndexHistory != 0) {
                  ref.read(pointsProvider.notifier).state.removeLast();
                  ref.read(graphicalPointsProvider.notifier).state.removeLast();
                  ref.read(currentIndexHistoryProvider.notifier).state--;
                }

                print('history: $historyPoints');
                print('current index: $currentIndexHistory');
              },
              svg: currentIndexHistory == 0
                  ? SvgPicture.asset('assets/images/undoDisabled.svg')
                  : SvgPicture.asset('assets/images/undo.svg'),
            ),

            //*divider
            Container(
              width: 0.5,
              height: 12,
              decoration: const BoxDecoration(
                color: kColorDivider,
              ),
            ),

            //*button redo
            ButtonCustom(
              onTap: () {
                print('redo');
                ref
                    .read(pointsProvider.notifier)
                    .state
                    .add(historyPoints[currentIndexHistory]);
              },
              svg: currentIndexHistory == historyPoints.length - 1
                  ? SvgPicture.asset('assets/images/redoDisabled.svg')
                  : SvgPicture.asset('assets/images/redo.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
