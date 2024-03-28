import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_polygon/data/provider.dart';

class ButtonCustom extends ConsumerWidget {
  final Widget svg;
  final VoidCallback onTap;
  const ButtonCustom({
    super.key,
    required this.svg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MouseRegion(
      onEnter: (event) {
        ref.read(isButtonsOnHoverProvider.notifier).state = true;
      },
      onExit: (event) {
        ref.read(isButtonsOnHoverProvider.notifier).state = false;
      },
      cursor: SystemMouseCursors.click,
      child: InkWell(
        // splashColor: Colors.red,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
          child: svg,
        ),
      ),
    );
  }
}
