import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final pointsProvider = StateProvider<List<Offset>>((ref) {
  List<Offset> points = [];
  return points;
});

final isPolygonProvider = StateProvider<bool>((ref) {
  bool isPolygon = false;
  return isPolygon;
});

final cursorPositionProvider = StateProvider<Offset>((ref) {
  Offset cursorPosition = Offset.zero;
  return cursorPosition;
});

final graphicalPointsProvider = StateProvider<List<Widget>>((ref) {
  final List<Widget> graphicalPoints = [];
  return graphicalPoints;
});

final isButtonsOnHoverProvider = StateProvider<bool>((ref) {
  bool isButtonsOnHover = false;
  return isButtonsOnHover;
});

final historyPointsProvider = StateProvider<List<Offset>>((ref) {
  List<Offset> historyPoints = [];
  return historyPoints;
});

final currentIndexHistoryProvider = StateProvider<int>((ref) {
  int currentIndexHistory = 0;
  return currentIndexHistory;
});
