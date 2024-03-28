import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sobol_polygon/const.dart';
import 'package:sobol_polygon/data/provider.dart';

//*snap to grid button
class FabCustom extends ConsumerWidget {
  const FabCustom({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 0, top: kHeightAppBar + 30),
        child: SizedBox(
          height: 46,
          width: 46,
          child: Stack(
            children: [
              Container(
                height: 46,
                width: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(-3, -2),
                    ),
                  ],
                ),
              ),
              MouseRegion(
                onEnter: (event) {
                  ref.read(isButtonsOnHoverProvider.notifier).state = true;
                },
                onExit: (event) {
                  ref.read(isButtonsOnHoverProvider.notifier).state = false;
                },
                child: FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     behavior: SnackBarBehavior.floating,
                    //     content: Text('Not available'),
                    //   ),
                    // );
                  },
                  backgroundColor: kColorButtonsBG,
                  shape: const CircleBorder(),
                  elevation: 0,
                  child: SvgPicture.asset('assets/images/grid.svg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
