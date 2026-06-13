import 'package:flutter/material.dart';

class AppShadows {
  AppShadows._();

  static List<BoxShadow> card = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 20,
      offset: const Offset(0, 10),
    ),
  ];

  static List<BoxShadow> hover = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 40,
      offset: const Offset(0, 20),
    ),
  ];
}