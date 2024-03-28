import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sobol_polygon/pages/home_page2.dart';
import 'package:sobol_polygon/themes.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sobol Polygon',
      debugShowCheckedModeBanner: false,
      theme: kThemeLight,
      home: const HomePage2(),
    );
  }
}
