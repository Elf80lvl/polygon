import 'package:flutter/material.dart';
import 'package:sobol_polygon/const.dart';

class AppBarCustom extends StatelessWidget {
  const AppBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kColorAppBarBG,
      elevation: 1,
      shadowColor: kColorAppBarShadow,
      surfaceTintColor: Colors.transparent,
    );
  }
}
