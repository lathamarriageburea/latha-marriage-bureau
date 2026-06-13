import 'package:flutter/material.dart';

class ResponsiveUtils {
  ResponsiveUtils._();

  static bool isMobile(BuildContext context) {
  final size = MediaQuery.of(context).size;

  return size.width < 768 || size.height < 500;
}

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 &&
        MediaQuery.of(context).size.width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double contentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width > 1400) {
      return 1400;
    }

    return width * 0.92;
  }
}